module ParserYAML

using ..LibYAML
using Dates

include("errors.jl")
include("resolvers.jl")
include("type_parsers.jl")

export parse_yaml, 
    open_yaml,
    YAMLError,
    YAMLMemoryError,
    YAMLReaderError,
    YAMLScannerError,
    YAMLParserError

const POSSIBLE_RETURN_TYPES = Union{Dict{String, Any}, Vector{Any}, Nothing}

#__ YAML parsers __#

@inline function init_parser(yaml_str::AbstractVector{UInt8})
    parser = Ref{YAMLParser}()
    success = yaml_parser_initialize(parser)
    success == 0 && throw_yaml_err(parser)
    yaml_parser_set_input_string(parser, pointer(yaml_str), sizeof(yaml_str))

    return parser
end

@inline function parse_documents(parser, file_dir)
    docs = POSSIBLE_RETURN_TYPES[]

    while true
        doc = Ref{YAMLDocument}()

        success = yaml_parser_load(parser, doc)
        success == 0 && throw_yaml_err(parser)

        root = yaml_document_get_root_node(doc) 
        root == C_NULL && break

        try
            res = parse_node(doc, root, file_dir)
            push!(docs, res)
        finally
            yaml_document_delete(doc)
        end
    end

    return docs
end

function parse_yaml_str(yaml_str::AbstractVector{UInt8}, file_dir)
    parser = init_parser(yaml_str)
    try
        return parse_documents(parser, file_dir)
    finally
        yaml_parser_delete(parser)
    end
end

@inline function parse_node(doc::Ref{YAMLDocument}, node_ptr::Ptr{YAMLNode}, file_dir)
    node = unsafe_load(node_ptr)
    node_type = node.type

    if node_type == YAML_SCALAR_NODE
        return parse_scalar(node, file_dir)
    elseif node_type == YAML_SEQUENCE_NODE
        return parse_sequence(doc, node, file_dir)
    elseif node_type == YAML_MAPPING_NODE
        return parse_mapping(doc, node, file_dir)
    else
        throw(YAMLError("Unsupported node type"))
    end
end

@inline function parse_value(tag, value, file_dir)
    if tag == "!include"
        parse_include(value, file_dir)
    elseif tag == YAML_INT_TAG
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

@inline function parse_scalar(node::YAMLNode, file_dir)
    tag = unsafe_string(node.tag)
    value = unsafe_string(node.data.scalar.value)

    parse_value(resolve_tag(value, tag), value, file_dir)
end

@inline function parse_sequence(doc::Ref{YAMLDocument}, node::YAMLNode, file_dir)
    items = node.data.sequence.items
    len = c_array_length(items.start, items.top, sizeof(Cuint))

    items_ptr = items.start
    yaml_arr = Vector{Any}(undef, len)
    @inbounds for i in 1:len
        idx_ptr = items_ptr + (i - 1) * sizeof(Cuint)
        idx = unsafe_load(idx_ptr)
        yaml_arr[i] = parse_node(doc, yaml_document_get_node(doc, idx), file_dir)
    end

    return yaml_arr
end

@inline function parse_mapping(doc::Ref{YAMLDocument}, node::YAMLNode, file_dir)
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
        val = parse_node(doc, val_ptr, file_dir)

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
1-element Vector{Any}:
Dict{Any, Any}(
    "dict" => Dict{Any, Any}(
        "b" => Any["w", "d"], 
        "a" => "1"
    ), 
    "name" => "Alice", 
    "array" => Any["1", "2", Dict{Any, Any}("b" => "null", "a" => "3")]
)
```
"""
parse_yaml(yaml::AbstractString) = parse_yaml_str(codeunits(yaml), "")
parse_yaml(yaml::AbstractVector{UInt8}) = parse_yaml_str(yaml, "")

"""
    open_yaml(path::AbstractString)

Read a YAML file from a given `path` and parse it.
"""
function open_yaml(path::AbstractString)
    abs_path = abspath(path)
    file_dir = dirname(abs_path)
    isfile(abs_path) || throw(YAMLError("File not found: $abs_path"))
    yaml = read(abs_path)

    return parse_yaml_str(yaml, file_dir)
end

"""
    open_yaml(io::IO)

Reads a YAML file from a given `io` and parse it.
"""
function open_yaml(io::IO)
    return parse_yaml_str(read(io), "")
end

end # module YAML
