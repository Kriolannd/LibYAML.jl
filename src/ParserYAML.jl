module ParserYAML

using ..LibYAML
using Dates

include("errors.jl")
include("resolvers.jl")
include("value_parsers.jl")

export parse_yaml, 
    open_yaml,
    YAMLError,
    YAMLMemoryError,
    YAMLReaderError,
    YAMLScannerError,
    YAMLParserError,
    Resolver

const POSSIBLE_RETURN_TYPES = Union{Dict{String, Any}, Vector{Any}, Nothing}

#__ YAML contexts __#

abstract type AbstractParseContext end

struct FileContext <: AbstractParseContext
    dir::String
    FileContext(path::AbstractString) = new(dirname(path))
end

struct StringContext <: AbstractParseContext end

#__ YAML parsers __#

@inline function init_parser(yaml_str::AbstractVector{UInt8})
    parser = Ref{YAMLParser}()
    success = yaml_parser_initialize(parser)
    success == 0 && throw_yaml_err(parser)
    yaml_parser_set_input_string(parser, pointer(yaml_str), sizeof(yaml_str))

    return parser
end

@inline function parse_documents(
    parser, 
    ctx::AbstractParseContext, 
    resolver::AbstractResolver,
)
    docs = POSSIBLE_RETURN_TYPES[]

    while true
        doc = Ref{YAMLDocument}()

        success = yaml_parser_load(parser, doc)
        success == 0 && throw_yaml_err(parser)

        root = yaml_document_get_root_node(doc) 
        root == C_NULL && break

        try
            res = parse_node(doc, root, ctx, resolver)
            push!(docs, res)
        finally
            yaml_document_delete(doc)
        end
    end

    return docs
end

function parse_yaml_file(
    resolver::AbstractResolver, 
    path::AbstractString; 
    multi::Bool=false,
)
    abs_path = abspath(path)
    isfile(abs_path) || throw(YAMLError("File not found: $abs_path"))
    return parse_yaml_str(resolver, FileContext(abs_path), read(abs_path); multi=multi)
end

function parse_yaml_str(
    resolver::AbstractResolver,
    ctx::AbstractParseContext, 
    yaml_str::AbstractVector{UInt8};
    multi::Bool,
)
    parser = init_parser(yaml_str)
    try
        docs = parse_documents(parser, ctx, resolver)
        isempty(docs) && return docs
        return multi ? docs : docs[1]
    finally
        yaml_parser_delete(parser)
    end
end

@inline function parse_node(
    doc::Ref{YAMLDocument}, 
    node_ptr::Ptr{YAMLNode}, 
    ctx::AbstractParseContext,
    resolver::AbstractResolver,
)
    node = unsafe_load(node_ptr)
    node_type = node.type

    if node_type == YAML_SCALAR_NODE
        return parse_scalar(node, ctx, resolver)
    elseif node_type == YAML_SEQUENCE_NODE
        return parse_sequence(doc, node, ctx, resolver)
    elseif node_type == YAML_MAPPING_NODE
        return parse_mapping(doc, node, ctx, resolver)
    else
        throw(YAMLError("Unsupported node type"))
    end
end

@inline function parse_value(tag, value)
    if tag == YAML_INT_TAG
        parse_int(value)
    elseif tag == YAML_FLOAT_TAG
        parse_float(value)
    elseif tag == YAML_BOOL_TAG
        parse_bool(value)
    elseif tag == YAML_TIMESTAMP_TAG
        parse_timestamp(value)
    elseif tag == YAML_NULL_TAG
        parse_null(value)
    else
        value
    end
end

@inline function parse_scalar(node::YAMLNode, ctx::FileContext, resolver::AbstractResolver)
    tag = unsafe_string(node.tag)
    value = unsafe_string(node.data.scalar.value)
    tag == "!include" && return parse_yaml_file(resolver, joinpath(ctx.dir, value))

    return parse_value(resolver(value, tag), value)
end

@inline function parse_scalar(node::YAMLNode, ctx::StringContext, resolver::AbstractResolver)
    tag = unsafe_string(node.tag)
    value = unsafe_string(node.data.scalar.value)

    return parse_value(resolver(value, tag), value)
end

@inline function parse_sequence(
    doc::Ref{YAMLDocument}, 
    node::YAMLNode, 
    ctx::AbstractParseContext,
    resolver::AbstractResolver,
)
    items = node.data.sequence.items
    len = c_array_length(items.start, items.top, sizeof(Cuint))

    items_ptr = items.start
    yaml_arr = Vector{Any}(undef, len)
    @inbounds for i in 1:len
        idx_ptr = items_ptr + (i - 1) * sizeof(Cuint)
        idx = unsafe_load(idx_ptr)
        yaml_arr[i] = parse_node(doc, yaml_document_get_node(doc, idx), ctx, resolver)
    end

    return yaml_arr
end

@inline function parse_mapping(
    doc::Ref{YAMLDocument}, 
    node::YAMLNode, 
    ctx::AbstractParseContext,
    resolver::AbstractResolver
)
    pairs = node.data.mapping.pairs
    len = c_array_length(pairs.start, pairs.top, sizeof(YAMLNodePair))

    pairs_ptr = pairs.start
    yaml_dict = Dict{String, Any}()
    @inbounds for i in 1:len
        pair_ptr = pairs_ptr + (i - 1) * sizeof(YAMLNodePair)
        pair = unsafe_load(pair_ptr)

        key_node = unsafe_load(yaml_document_get_node(doc, pair.key))
        key = unsafe_string(key_node.data.scalar.value)
        val_ptr = yaml_document_get_node(doc, pair.value)
        val_node = unsafe_load(val_ptr)
        val = parse_node(doc, val_ptr, ctx, resolver)

        if key == "<<" 
            merge_anchor!(yaml_dict, val, val_node.type)
        else
            yaml_dict[key] = val
        end
    end

    return yaml_dict
end

#__ YAML helpers __#

@inline function merge_anchor!(yaml_dict, val, type)
    if type == YAML_MAPPING_NODE
        merge!(yaml_dict, val)
    elseif type == YAML_SEQUENCE_NODE
        for submap in val
            merge!(yaml_dict, submap)
        end
    end

    return nothing
end

@inline c_array_length(start, top, size) = (top - start) ÷ size

#__ YAML interface __#

"""
    parse_yaml(yaml_str::String)
    parse_yaml(yaml_str::Vector{UInt8})

Parse a YAML string or file (or vector of `UInt8`) into a dictionary, vector or nothing. 
- If a given YAML document contains a dictionary, the parser returns a dictionary.
- If a given YAML document contains just a list of variables, the parser returns a vector.
- If a given YAML document contains no information (i.e. empty), the parser returns nothing
or empty dictionary.

Returns a sequence of documents parsed from YAML string given.

## Examples
```julia
julia> yaml_str = \"\"\"
        name: Alice
        array: 
          - 1
          - 2
          - a: 3 
            b: null
        dict: 
          a: 1
          b: 
            - w
            - d
       \"\"\";

julia> parse_yaml(yaml_str)
Dict{String, Any}(
    "dict" => Dict{Any, Any}(
        "b" => Any["w", "d"], 
        "a" => "1"
    ), 
    "name" => "Alice", 
    "array" => Any["1", "2", Dict{Any, Any}("b" => "null", "a" => "3")]
)
```
"""
function parse_yaml(
    yaml::AbstractString; 
    multi::Bool=false, 
    resolver=Resolver(),
)
    return parse_yaml_str(
        resolver::AbstractResolver, 
        StringContext(), 
        codeunits(yaml), 
        multi=multi,
    )
end

function parse_yaml(
    yaml::AbstractVector{UInt8}; 
    multi::Bool=false, 
    resolver=Resolver(),
)
    return parse_yaml_str(resolver::AbstractResolver, StringContext(), yaml, multi=multi)
end

"""
    open_yaml(path::AbstractString)

Read a YAML file from a given `path` and parse it.
"""
open_yaml(
    path::AbstractString; 
    multi::Bool=false, 
    resolver=Resolver(),
) = parse_yaml_file(resolver, path, multi=multi)

"""
    open_yaml(io::IO)

Reads a YAML file from a given `io` and parse it.
"""
open_yaml(io::IO; multi::Bool=false, resolver=Resolver()) = 
    parse_yaml_str(resolver::AbstractResolver, StringContext(), read(io), multi=multi)

end # module YAML
