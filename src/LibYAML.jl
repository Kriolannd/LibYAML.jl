module LibYAML

using LibYAML_jll
export LibYAML_jll

using CEnum



"""
    yaml_get_version_string()

Get the library version as a string.

# Returns
The function returns the pointer to a static string of the form `"X.Y.Z",` where `X` is the major version number, `Y` is a minor version number, and `Z` is the patch version number.
"""
function yaml_get_version_string()
    @ccall libyaml.yaml_get_version_string()::Cstring
end

"""
    yaml_get_version(major, minor, patch)

Get the library version numbers.

# Arguments
* `major`:\\[out\\] Major version number.
* `minor`:\\[out\\] Minor version number.
* `patch`:\\[out\\] Patch version number.
"""
function yaml_get_version(major, minor, patch)
    @ccall libyaml.yaml_get_version(major::Ptr{Cint}, minor::Ptr{Cint}, patch::Ptr{Cint})::Cvoid
end

"""
The character type (UTF-8 octet).
"""
const yaml_char_t = Cuchar

"""
    yaml_version_directive_s

The version directive data.

| Field | Note                       |
| :---- | :------------------------- |
| major | The major version number.  |
| minor | The minor version number.  |
"""
struct yaml_version_directive_s
    major::Cint
    minor::Cint
end

"""
The version directive data.
"""
const yaml_version_directive_t = yaml_version_directive_s

"""
    yaml_tag_directive_s

The tag directive data.

| Field  | Note             |
| :----- | :--------------- |
| handle | The tag handle.  |
| prefix | The tag prefix.  |
"""
struct yaml_tag_directive_s
    handle::Ptr{yaml_char_t}
    prefix::Ptr{yaml_char_t}
end

"""
The tag directive data.
"""
const yaml_tag_directive_t = yaml_tag_directive_s

"""
    yaml_encoding_e

The stream encoding.

| Enumerator                | Note                                 |
| :------------------------ | :----------------------------------- |
| YAML\\_ANY\\_ENCODING     | Let the parser choose the encoding.  |
| YAML\\_UTF8\\_ENCODING    | The default UTF-8 encoding.          |
| YAML\\_UTF16LE\\_ENCODING | The UTF-16-LE encoding with BOM.     |
| YAML\\_UTF16BE\\_ENCODING | The UTF-16-BE encoding with BOM.     |
"""
@cenum yaml_encoding_e::UInt32 begin
    YAML_ANY_ENCODING = 0
    YAML_UTF8_ENCODING = 1
    YAML_UTF16LE_ENCODING = 2
    YAML_UTF16BE_ENCODING = 3
end

"""
The stream encoding.
"""
const yaml_encoding_t = yaml_encoding_e

"""
    yaml_break_e

Line break types.

| Enumerator          | Note                                    |
| :------------------ | :-------------------------------------- |
| YAML\\_ANY\\_BREAK  | Let the parser choose the break type.   |
| YAML\\_CR\\_BREAK   | Use CR for line breaks (Mac style).     |
| YAML\\_LN\\_BREAK   | Use LN for line breaks (Unix style).    |
| YAML\\_CRLN\\_BREAK | Use CR LN for line breaks (DOS style).  |
"""
@cenum yaml_break_e::UInt32 begin
    YAML_ANY_BREAK = 0
    YAML_CR_BREAK = 1
    YAML_LN_BREAK = 2
    YAML_CRLN_BREAK = 3
end

"""
Line break types.
"""
const yaml_break_t = yaml_break_e

"""
    yaml_error_type_e

Many bad things could happen with the parser and emitter.

| Enumerator              | Note                                              |
| :---------------------- | :------------------------------------------------ |
| YAML\\_NO\\_ERROR       | No error is produced.                             |
| YAML\\_MEMORY\\_ERROR   | Cannot allocate or reallocate a block of memory.  |
| YAML\\_READER\\_ERROR   | Cannot read or decode the input stream.           |
| YAML\\_SCANNER\\_ERROR  | Cannot scan the input stream.                     |
| YAML\\_PARSER\\_ERROR   | Cannot parse the input stream.                    |
| YAML\\_COMPOSER\\_ERROR | Cannot compose a YAML document.                   |
| YAML\\_WRITER\\_ERROR   | Cannot write to the output stream.                |
| YAML\\_EMITTER\\_ERROR  | Cannot emit a YAML stream.                        |
"""
@cenum yaml_error_type_e::UInt32 begin
    YAML_NO_ERROR = 0
    YAML_MEMORY_ERROR = 1
    YAML_READER_ERROR = 2
    YAML_SCANNER_ERROR = 3
    YAML_PARSER_ERROR = 4
    YAML_COMPOSER_ERROR = 5
    YAML_WRITER_ERROR = 6
    YAML_EMITTER_ERROR = 7
end

"""
Many bad things could happen with the parser and emitter.
"""
const yaml_error_type_t = yaml_error_type_e

"""
    yaml_mark_s

The pointer position.

| Field  | Note                  |
| :----- | :-------------------- |
| index  | The position index.   |
| line   | The position line.    |
| column | The position column.  |
"""
struct yaml_mark_s
    index::Csize_t
    line::Csize_t
    column::Csize_t
end

"""
The pointer position.
"""
const yaml_mark_t = yaml_mark_s

"""
    yaml_scalar_style_e

Scalar styles.

| Enumerator                              | Note                               |
| :-------------------------------------- | :--------------------------------- |
| YAML\\_ANY\\_SCALAR\\_STYLE             | Let the emitter choose the style.  |
| YAML\\_PLAIN\\_SCALAR\\_STYLE           | The plain scalar style.            |
| YAML\\_SINGLE\\_QUOTED\\_SCALAR\\_STYLE | The single-quoted scalar style.    |
| YAML\\_DOUBLE\\_QUOTED\\_SCALAR\\_STYLE | The double-quoted scalar style.    |
| YAML\\_LITERAL\\_SCALAR\\_STYLE         | The literal scalar style.          |
| YAML\\_FOLDED\\_SCALAR\\_STYLE          | The folded scalar style.           |
"""
@cenum yaml_scalar_style_e::UInt32 begin
    YAML_ANY_SCALAR_STYLE = 0
    YAML_PLAIN_SCALAR_STYLE = 1
    YAML_SINGLE_QUOTED_SCALAR_STYLE = 2
    YAML_DOUBLE_QUOTED_SCALAR_STYLE = 3
    YAML_LITERAL_SCALAR_STYLE = 4
    YAML_FOLDED_SCALAR_STYLE = 5
end

"""
Scalar styles.
"""
const yaml_scalar_style_t = yaml_scalar_style_e

"""
    yaml_sequence_style_e

Sequence styles.

| Enumerator                      | Note                               |
| :------------------------------ | :--------------------------------- |
| YAML\\_ANY\\_SEQUENCE\\_STYLE   | Let the emitter choose the style.  |
| YAML\\_BLOCK\\_SEQUENCE\\_STYLE | The block sequence style.          |
| YAML\\_FLOW\\_SEQUENCE\\_STYLE  | The flow sequence style.           |
"""
@cenum yaml_sequence_style_e::UInt32 begin
    YAML_ANY_SEQUENCE_STYLE = 0
    YAML_BLOCK_SEQUENCE_STYLE = 1
    YAML_FLOW_SEQUENCE_STYLE = 2
end

"""
Sequence styles.
"""
const yaml_sequence_style_t = yaml_sequence_style_e

"""
    yaml_mapping_style_e

Mapping styles.

| Enumerator                     | Note                               |
| :----------------------------- | :--------------------------------- |
| YAML\\_ANY\\_MAPPING\\_STYLE   | Let the emitter choose the style.  |
| YAML\\_BLOCK\\_MAPPING\\_STYLE | The block mapping style.           |
| YAML\\_FLOW\\_MAPPING\\_STYLE  | The flow mapping style.            |
"""
@cenum yaml_mapping_style_e::UInt32 begin
    YAML_ANY_MAPPING_STYLE = 0
    YAML_BLOCK_MAPPING_STYLE = 1
    YAML_FLOW_MAPPING_STYLE = 2
end

"""
Mapping styles.
"""
const yaml_mapping_style_t = yaml_mapping_style_e

"""
    yaml_token_type_e

Token types.

| Enumerator                              | Note                           |
| :-------------------------------------- | :----------------------------- |
| YAML\\_NO\\_TOKEN                       | An empty token.                |
| YAML\\_STREAM\\_START\\_TOKEN           | A STREAM-START token.          |
| YAML\\_STREAM\\_END\\_TOKEN             | A STREAM-END token.            |
| YAML\\_VERSION\\_DIRECTIVE\\_TOKEN      | A VERSION-DIRECTIVE token.     |
| YAML\\_TAG\\_DIRECTIVE\\_TOKEN          | A TAG-DIRECTIVE token.         |
| YAML\\_DOCUMENT\\_START\\_TOKEN         | A DOCUMENT-START token.        |
| YAML\\_DOCUMENT\\_END\\_TOKEN           | A DOCUMENT-END token.          |
| YAML\\_BLOCK\\_SEQUENCE\\_START\\_TOKEN | A BLOCK-SEQUENCE-START token.  |
| YAML\\_BLOCK\\_MAPPING\\_START\\_TOKEN  | A BLOCK-MAPPING-START token.   |
| YAML\\_BLOCK\\_END\\_TOKEN              | A BLOCK-END token.             |
| YAML\\_FLOW\\_SEQUENCE\\_START\\_TOKEN  | A FLOW-SEQUENCE-START token.   |
| YAML\\_FLOW\\_SEQUENCE\\_END\\_TOKEN    | A FLOW-SEQUENCE-END token.     |
| YAML\\_FLOW\\_MAPPING\\_START\\_TOKEN   | A FLOW-MAPPING-START token.    |
| YAML\\_FLOW\\_MAPPING\\_END\\_TOKEN     | A FLOW-MAPPING-END token.      |
| YAML\\_BLOCK\\_ENTRY\\_TOKEN            | A BLOCK-ENTRY token.           |
| YAML\\_FLOW\\_ENTRY\\_TOKEN             | A FLOW-ENTRY token.            |
| YAML\\_KEY\\_TOKEN                      | A KEY token.                   |
| YAML\\_VALUE\\_TOKEN                    | A VALUE token.                 |
| YAML\\_ALIAS\\_TOKEN                    | An ALIAS token.                |
| YAML\\_ANCHOR\\_TOKEN                   | An ANCHOR token.               |
| YAML\\_TAG\\_TOKEN                      | A TAG token.                   |
| YAML\\_SCALAR\\_TOKEN                   | A SCALAR token.                |
"""
@cenum yaml_token_type_e::UInt32 begin
    YAML_NO_TOKEN = 0
    YAML_STREAM_START_TOKEN = 1
    YAML_STREAM_END_TOKEN = 2
    YAML_VERSION_DIRECTIVE_TOKEN = 3
    YAML_TAG_DIRECTIVE_TOKEN = 4
    YAML_DOCUMENT_START_TOKEN = 5
    YAML_DOCUMENT_END_TOKEN = 6
    YAML_BLOCK_SEQUENCE_START_TOKEN = 7
    YAML_BLOCK_MAPPING_START_TOKEN = 8
    YAML_BLOCK_END_TOKEN = 9
    YAML_FLOW_SEQUENCE_START_TOKEN = 10
    YAML_FLOW_SEQUENCE_END_TOKEN = 11
    YAML_FLOW_MAPPING_START_TOKEN = 12
    YAML_FLOW_MAPPING_END_TOKEN = 13
    YAML_BLOCK_ENTRY_TOKEN = 14
    YAML_FLOW_ENTRY_TOKEN = 15
    YAML_KEY_TOKEN = 16
    YAML_VALUE_TOKEN = 17
    YAML_ALIAS_TOKEN = 18
    YAML_ANCHOR_TOKEN = 19
    YAML_TAG_TOKEN = 20
    YAML_SCALAR_TOKEN = 21
end

"""
Token types.
"""
const yaml_token_type_t = yaml_token_type_e

"""
    __JL_Ctag_45

The token data.
"""
struct __JL_Ctag_45
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_45}, f::Symbol)
    f === :stream_start && return Ptr{__JL_Ctag_46}(x + 0)
    f === :alias && return Ptr{__JL_Ctag_47}(x + 0)
    f === :anchor && return Ptr{__JL_Ctag_48}(x + 0)
    f === :tag && return Ptr{__JL_Ctag_49}(x + 0)
    f === :scalar && return Ptr{__JL_Ctag_50}(x + 0)
    f === :version_directive && return Ptr{__JL_Ctag_51}(x + 0)
    f === :tag_directive && return Ptr{__JL_Ctag_52}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_45, f::Symbol)
    r = Ref{__JL_Ctag_45}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_45}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_45}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
    yaml_token_s

The token structure.

| Field        | Note                         |
| :----------- | :--------------------------- |
| type         | The token type.              |
| start\\_mark | The beginning of the token.  |
| end\\_mark   | The end of the token.        |
"""
struct yaml_token_s
    data::NTuple{80, UInt8}
end

function Base.getproperty(x::Ptr{yaml_token_s}, f::Symbol)
    f === :type && return Ptr{yaml_token_type_t}(x + 0)
    f === :data && return Ptr{__JL_Ctag_45}(x + 8)
    f === :start_mark && return Ptr{yaml_mark_t}(x + 32)
    f === :end_mark && return Ptr{yaml_mark_t}(x + 56)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_token_s, f::Symbol)
    r = Ref{yaml_token_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_token_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_token_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
The token structure.
"""
const yaml_token_t = yaml_token_s

"""
    yaml_token_delete(token)

Free any memory allocated for a token object.

# Arguments
* `token`:\\[in,out\\] A token object.
"""
function yaml_token_delete(token)
    @ccall libyaml.yaml_token_delete(token::Ptr{yaml_token_t})::Cvoid
end

"""
    yaml_event_type_e

Event types.

| Enumerator                      | Note                     |
| :------------------------------ | :----------------------- |
| YAML\\_NO\\_EVENT               | An empty event.          |
| YAML\\_STREAM\\_START\\_EVENT   | A STREAM-START event.    |
| YAML\\_STREAM\\_END\\_EVENT     | A STREAM-END event.      |
| YAML\\_DOCUMENT\\_START\\_EVENT | A DOCUMENT-START event.  |
| YAML\\_DOCUMENT\\_END\\_EVENT   | A DOCUMENT-END event.    |
| YAML\\_ALIAS\\_EVENT            | An ALIAS event.          |
| YAML\\_SCALAR\\_EVENT           | A SCALAR event.          |
| YAML\\_SEQUENCE\\_START\\_EVENT | A SEQUENCE-START event.  |
| YAML\\_SEQUENCE\\_END\\_EVENT   | A SEQUENCE-END event.    |
| YAML\\_MAPPING\\_START\\_EVENT  | A MAPPING-START event.   |
| YAML\\_MAPPING\\_END\\_EVENT    | A MAPPING-END event.     |
"""
@cenum yaml_event_type_e::UInt32 begin
    YAML_NO_EVENT = 0
    YAML_STREAM_START_EVENT = 1
    YAML_STREAM_END_EVENT = 2
    YAML_DOCUMENT_START_EVENT = 3
    YAML_DOCUMENT_END_EVENT = 4
    YAML_ALIAS_EVENT = 5
    YAML_SCALAR_EVENT = 6
    YAML_SEQUENCE_START_EVENT = 7
    YAML_SEQUENCE_END_EVENT = 8
    YAML_MAPPING_START_EVENT = 9
    YAML_MAPPING_END_EVENT = 10
end

"""
Event types.
"""
const yaml_event_type_t = yaml_event_type_e

"""
    __JL_Ctag_30

The event data.
"""
struct __JL_Ctag_30
    data::NTuple{48, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_30}, f::Symbol)
    f === :stream_start && return Ptr{__JL_Ctag_31}(x + 0)
    f === :document_start && return Ptr{Cvoid}(x + 0)
    f === :document_end && return Ptr{__JL_Ctag_34}(x + 0)
    f === :alias && return Ptr{__JL_Ctag_35}(x + 0)
    f === :scalar && return Ptr{__JL_Ctag_36}(x + 0)
    f === :sequence_start && return Ptr{__JL_Ctag_37}(x + 0)
    f === :mapping_start && return Ptr{__JL_Ctag_38}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_30, f::Symbol)
    r = Ref{__JL_Ctag_30}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_30}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_30}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
    yaml_event_s

The event structure.

| Field        | Note                         |
| :----------- | :--------------------------- |
| type         | The event type.              |
| start\\_mark | The beginning of the event.  |
| end\\_mark   | The end of the event.        |
"""
struct yaml_event_s
    data::NTuple{104, UInt8}
end

function Base.getproperty(x::Ptr{yaml_event_s}, f::Symbol)
    f === :type && return Ptr{yaml_event_type_t}(x + 0)
    f === :data && return Ptr{__JL_Ctag_30}(x + 8)
    f === :start_mark && return Ptr{yaml_mark_t}(x + 56)
    f === :end_mark && return Ptr{yaml_mark_t}(x + 80)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_event_s, f::Symbol)
    r = Ref{yaml_event_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_event_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_event_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
The event structure.
"""
const yaml_event_t = yaml_event_s

"""
    yaml_stream_start_event_initialize(event, encoding)

Create the STREAM-START event.

# Arguments
* `event`:\\[out\\] An empty event object.
* `encoding`:\\[in\\] The stream encoding.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_stream_start_event_initialize(event, encoding)
    @ccall libyaml.yaml_stream_start_event_initialize(event::Ptr{yaml_event_t}, encoding::yaml_encoding_t)::Cint
end

"""
    yaml_stream_end_event_initialize(event)

Create the STREAM-END event.

# Arguments
* `event`:\\[out\\] An empty event object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_stream_end_event_initialize(event)
    @ccall libyaml.yaml_stream_end_event_initialize(event::Ptr{yaml_event_t})::Cint
end

"""
    yaml_document_start_event_initialize(event, version_directive, tag_directives_start, tag_directives_end, implicit)

Create the DOCUMENT-START event.

The *implicit* argument is considered as a stylistic parameter and may be ignored by the emitter.

# Arguments
* `event`:\\[out\\] An empty event object.
* `version_directive`:\\[in\\] The YAML directive value or `NULL`.
* `tag_directives_start`:\\[in\\] The beginning of the TAG directives list.
* `tag_directives_end`:\\[in\\] The end of the TAG directives list.
* `implicit`:\\[in\\] If the document start indicator is implicit.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_document_start_event_initialize(event, version_directive, tag_directives_start, tag_directives_end, implicit)
    @ccall libyaml.yaml_document_start_event_initialize(event::Ptr{yaml_event_t}, version_directive::Ptr{yaml_version_directive_t}, tag_directives_start::Ptr{yaml_tag_directive_t}, tag_directives_end::Ptr{yaml_tag_directive_t}, implicit::Cint)::Cint
end

"""
    yaml_document_end_event_initialize(event, implicit)

Create the DOCUMENT-END event.

The *implicit* argument is considered as a stylistic parameter and may be ignored by the emitter.

# Arguments
* `event`:\\[out\\] An empty event object.
* `implicit`:\\[in\\] If the document end indicator is implicit.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_document_end_event_initialize(event, implicit)
    @ccall libyaml.yaml_document_end_event_initialize(event::Ptr{yaml_event_t}, implicit::Cint)::Cint
end

"""
    yaml_alias_event_initialize(event, anchor)

Create an ALIAS event.

# Arguments
* `event`:\\[out\\] An empty event object.
* `anchor`:\\[in\\] The anchor value.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_alias_event_initialize(event, anchor)
    @ccall libyaml.yaml_alias_event_initialize(event::Ptr{yaml_event_t}, anchor::Ptr{yaml_char_t})::Cint
end

"""
    yaml_scalar_event_initialize(event, anchor, tag, value, length, plain_implicit, quoted_implicit, style)

Create a SCALAR event.

The *style* argument may be ignored by the emitter.

Either the *tag* attribute or one of the *plain_implicit* and *quoted_implicit* flags must be set.

# Arguments
* `event`:\\[out\\] An empty event object.
* `anchor`:\\[in\\] The scalar anchor or `NULL`.
* `tag`:\\[in\\] The scalar tag or `NULL`.
* `value`:\\[in\\] The scalar value.
* `length`:\\[in\\] The length of the scalar value.
* `plain_implicit`:\\[in\\] If the tag may be omitted for the plain style.
* `quoted_implicit`:\\[in\\] If the tag may be omitted for any non-plain style.
* `style`:\\[in\\] The scalar style.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_scalar_event_initialize(event, anchor, tag, value, length, plain_implicit, quoted_implicit, style)
    @ccall libyaml.yaml_scalar_event_initialize(event::Ptr{yaml_event_t}, anchor::Ptr{yaml_char_t}, tag::Ptr{yaml_char_t}, value::Ptr{yaml_char_t}, length::Cint, plain_implicit::Cint, quoted_implicit::Cint, style::yaml_scalar_style_t)::Cint
end

"""
    yaml_sequence_start_event_initialize(event, anchor, tag, implicit, style)

Create a SEQUENCE-START event.

The *style* argument may be ignored by the emitter.

Either the *tag* attribute or the *implicit* flag must be set.

# Arguments
* `event`:\\[out\\] An empty event object.
* `anchor`:\\[in\\] The sequence anchor or `NULL`.
* `tag`:\\[in\\] The sequence tag or `NULL`.
* `implicit`:\\[in\\] If the tag may be omitted.
* `style`:\\[in\\] The sequence style.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_sequence_start_event_initialize(event, anchor, tag, implicit, style)
    @ccall libyaml.yaml_sequence_start_event_initialize(event::Ptr{yaml_event_t}, anchor::Ptr{yaml_char_t}, tag::Ptr{yaml_char_t}, implicit::Cint, style::yaml_sequence_style_t)::Cint
end

"""
    yaml_sequence_end_event_initialize(event)

Create a SEQUENCE-END event.

# Arguments
* `event`:\\[out\\] An empty event object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_sequence_end_event_initialize(event)
    @ccall libyaml.yaml_sequence_end_event_initialize(event::Ptr{yaml_event_t})::Cint
end

"""
    yaml_mapping_start_event_initialize(event, anchor, tag, implicit, style)

Create a MAPPING-START event.

The *style* argument may be ignored by the emitter.

Either the *tag* attribute or the *implicit* flag must be set.

# Arguments
* `event`:\\[out\\] An empty event object.
* `anchor`:\\[in\\] The mapping anchor or `NULL`.
* `tag`:\\[in\\] The mapping tag or `NULL`.
* `implicit`:\\[in\\] If the tag may be omitted.
* `style`:\\[in\\] The mapping style.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_mapping_start_event_initialize(event, anchor, tag, implicit, style)
    @ccall libyaml.yaml_mapping_start_event_initialize(event::Ptr{yaml_event_t}, anchor::Ptr{yaml_char_t}, tag::Ptr{yaml_char_t}, implicit::Cint, style::yaml_mapping_style_t)::Cint
end

"""
    yaml_mapping_end_event_initialize(event)

Create a MAPPING-END event.

# Arguments
* `event`:\\[out\\] An empty event object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_mapping_end_event_initialize(event)
    @ccall libyaml.yaml_mapping_end_event_initialize(event::Ptr{yaml_event_t})::Cint
end

"""
    yaml_event_delete(event)

Free any memory allocated for an event object.

# Arguments
* `event`:\\[in,out\\] An event object.
"""
function yaml_event_delete(event)
    @ccall libyaml.yaml_event_delete(event::Ptr{yaml_event_t})::Cvoid
end

"""
    yaml_node_type_e

Node types.

| Enumerator             | Note              |
| :--------------------- | :---------------- |
| YAML\\_NO\\_NODE       | An empty node.    |
| YAML\\_SCALAR\\_NODE   | A scalar node.    |
| YAML\\_SEQUENCE\\_NODE | A sequence node.  |
| YAML\\_MAPPING\\_NODE  | A mapping node.   |
"""
@cenum yaml_node_type_e::UInt32 begin
    YAML_NO_NODE = 0
    YAML_SCALAR_NODE = 1
    YAML_SEQUENCE_NODE = 2
    YAML_MAPPING_NODE = 3
end

"""
Node types.
"""
const yaml_node_type_t = yaml_node_type_e

"""
    __JL_Ctag_39

The node data.
"""
struct __JL_Ctag_39
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_39}, f::Symbol)
    f === :scalar && return Ptr{__JL_Ctag_40}(x + 0)
    f === :sequence && return Ptr{__JL_Ctag_41}(x + 0)
    f === :mapping && return Ptr{__JL_Ctag_43}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_39, f::Symbol)
    r = Ref{__JL_Ctag_39}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_39}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_39}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
    yaml_node_s

The node structure.

| Field        | Note                        |
| :----------- | :-------------------------- |
| type         | The node type.              |
| tag          | The node tag.               |
| start\\_mark | The beginning of the node.  |
| end\\_mark   | The end of the node.        |
"""
struct yaml_node_s
    data::NTuple{96, UInt8}
end

function Base.getproperty(x::Ptr{yaml_node_s}, f::Symbol)
    f === :type && return Ptr{yaml_node_type_t}(x + 0)
    f === :tag && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :data && return Ptr{__JL_Ctag_39}(x + 16)
    f === :start_mark && return Ptr{yaml_mark_t}(x + 48)
    f === :end_mark && return Ptr{yaml_mark_t}(x + 72)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_node_s, f::Symbol)
    r = Ref{yaml_node_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_node_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_node_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
The forward definition of a document node structure.
"""
const yaml_node_t = yaml_node_s

"""
An element of a sequence node.
"""
const yaml_node_item_t = Cint

"""
    yaml_node_pair_s

An element of a mapping node.

| Field | Note                       |
| :---- | :------------------------- |
| key   | The key of the element.    |
| value | The value of the element.  |
"""
struct yaml_node_pair_s
    key::Cint
    value::Cint
end

"""
An element of a mapping node.
"""
const yaml_node_pair_t = yaml_node_pair_s

"""
    __JL_Ctag_28

The document nodes.

| Field | Note                         |
| :---- | :--------------------------- |
| start | The beginning of the stack.  |
| end   | The end of the stack.        |
| top   | The top of the stack.        |
"""
struct __JL_Ctag_28
    start::Ptr{yaml_node_t}
    _end::Ptr{yaml_node_t}
    top::Ptr{yaml_node_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_28}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_node_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_node_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_node_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_28, f::Symbol)
    r = Ref{__JL_Ctag_28}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_28}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_28}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_29

The list of tag directives.

| Field | Note                                       |
| :---- | :----------------------------------------- |
| start | The beginning of the tag directives list.  |
| end   | The end of the tag directives list.        |
"""
struct __JL_Ctag_29
    start::Ptr{yaml_tag_directive_t}
    _end::Ptr{yaml_tag_directive_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_29}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_tag_directive_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_tag_directive_t}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_29, f::Symbol)
    r = Ref{__JL_Ctag_29}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_29}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_29}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    yaml_document_s

The document structure.

| Field               | Note                                       |
| :------------------ | :----------------------------------------- |
| version\\_directive | The version directive.                     |
| start\\_implicit    | Is the document start indicator implicit?  |
| end\\_implicit      | Is the document end indicator implicit?    |
| start\\_mark        | The beginning of the document.             |
| end\\_mark          | The end of the document.                   |
"""
struct yaml_document_s
    data::NTuple{104, UInt8}
end

function Base.getproperty(x::Ptr{yaml_document_s}, f::Symbol)
    f === :nodes && return Ptr{__JL_Ctag_28}(x + 0)
    f === :version_directive && return Ptr{Ptr{yaml_version_directive_t}}(x + 24)
    f === :tag_directives && return Ptr{__JL_Ctag_29}(x + 32)
    f === :start_implicit && return Ptr{Cint}(x + 48)
    f === :end_implicit && return Ptr{Cint}(x + 52)
    f === :start_mark && return Ptr{yaml_mark_t}(x + 56)
    f === :end_mark && return Ptr{yaml_mark_t}(x + 80)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_document_s, f::Symbol)
    r = Ref{yaml_document_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_document_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_document_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
The document structure.
"""
const yaml_document_t = yaml_document_s

"""
    yaml_document_initialize(document, version_directive, tag_directives_start, tag_directives_end, start_implicit, end_implicit)

Create a YAML document.

# Arguments
* `document`:\\[out\\] An empty document object.
* `version_directive`:\\[in\\] The YAML directive value or `NULL`.
* `tag_directives_start`:\\[in\\] The beginning of the TAG directives list.
* `tag_directives_end`:\\[in\\] The end of the TAG directives list.
* `start_implicit`:\\[in\\] If the document start indicator is implicit.
* `end_implicit`:\\[in\\] If the document end indicator is implicit.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_document_initialize(document, version_directive, tag_directives_start, tag_directives_end, start_implicit, end_implicit)
    @ccall libyaml.yaml_document_initialize(document::Ptr{yaml_document_t}, version_directive::Ptr{yaml_version_directive_t}, tag_directives_start::Ptr{yaml_tag_directive_t}, tag_directives_end::Ptr{yaml_tag_directive_t}, start_implicit::Cint, end_implicit::Cint)::Cint
end

"""
    yaml_document_delete(document)

Delete a YAML document and all its nodes.

# Arguments
* `document`:\\[in,out\\] A document object.
"""
function yaml_document_delete(document)
    @ccall libyaml.yaml_document_delete(document::Ptr{yaml_document_t})::Cvoid
end

"""
    yaml_document_get_node(document, index)

Get a node of a YAML document.

The pointer returned by this function is valid until any of the functions modifying the documents are called.

# Arguments
* `document`:\\[in\\] A document object.
* `index`:\\[in\\] The node id.
# Returns
the node objct or `NULL` if `node_id` is out of range.
"""
function yaml_document_get_node(document, index)
    @ccall libyaml.yaml_document_get_node(document::Ptr{yaml_document_t}, index::Cint)::Ptr{yaml_node_t}
end

"""
    yaml_document_get_root_node(document)

Get the root of a YAML document node.

The root object is the first object added to the document.

The pointer returned by this function is valid until any of the functions modifying the documents are called.

An empty document produced by the parser signifies the end of a YAML stream.

# Arguments
* `document`:\\[in\\] A document object.
# Returns
the node object or `NULL` if the document is empty.
"""
function yaml_document_get_root_node(document)
    @ccall libyaml.yaml_document_get_root_node(document::Ptr{yaml_document_t})::Ptr{yaml_node_t}
end

"""
    yaml_document_add_scalar(document, tag, value, length, style)

Create a SCALAR node and attach it to the document.

The *style* argument may be ignored by the emitter.

# Arguments
* `document`:\\[in,out\\] A document object.
* `tag`:\\[in\\] The scalar tag.
* `value`:\\[in\\] The scalar value.
* `length`:\\[in\\] The length of the scalar value.
* `style`:\\[in\\] The scalar style.
# Returns
the node id or `0` on error.
"""
function yaml_document_add_scalar(document, tag, value, length, style)
    @ccall libyaml.yaml_document_add_scalar(document::Ptr{yaml_document_t}, tag::Ptr{yaml_char_t}, value::Ptr{yaml_char_t}, length::Cint, style::yaml_scalar_style_t)::Cint
end

"""
    yaml_document_add_sequence(document, tag, style)

Create a SEQUENCE node and attach it to the document.

The *style* argument may be ignored by the emitter.

# Arguments
* `document`:\\[in,out\\] A document object.
* `tag`:\\[in\\] The sequence tag.
* `style`:\\[in\\] The sequence style.
# Returns
the node id or `0` on error.
"""
function yaml_document_add_sequence(document, tag, style)
    @ccall libyaml.yaml_document_add_sequence(document::Ptr{yaml_document_t}, tag::Ptr{yaml_char_t}, style::yaml_sequence_style_t)::Cint
end

"""
    yaml_document_add_mapping(document, tag, style)

Create a MAPPING node and attach it to the document.

The *style* argument may be ignored by the emitter.

# Arguments
* `document`:\\[in,out\\] A document object.
* `tag`:\\[in\\] The sequence tag.
* `style`:\\[in\\] The sequence style.
# Returns
the node id or `0` on error.
"""
function yaml_document_add_mapping(document, tag, style)
    @ccall libyaml.yaml_document_add_mapping(document::Ptr{yaml_document_t}, tag::Ptr{yaml_char_t}, style::yaml_mapping_style_t)::Cint
end

"""
    yaml_document_append_sequence_item(document, sequence, item)

Add an item to a SEQUENCE node.

# Arguments
* `document`:\\[in,out\\] A document object.
* `sequence`:\\[in\\] The sequence node id.
* `item`:\\[in\\] The item node id.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_document_append_sequence_item(document, sequence, item)
    @ccall libyaml.yaml_document_append_sequence_item(document::Ptr{yaml_document_t}, sequence::Cint, item::Cint)::Cint
end

"""
    yaml_document_append_mapping_pair(document, mapping, key, value)

Add a pair of a key and a value to a MAPPING node.

# Arguments
* `document`:\\[in,out\\] A document object.
* `mapping`:\\[in\\] The mapping node id.
* `key`:\\[in\\] The key node id.
* `value`:\\[in\\] The value node id.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_document_append_mapping_pair(document, mapping, key, value)
    @ccall libyaml.yaml_document_append_mapping_pair(document::Ptr{yaml_document_t}, mapping::Cint, key::Cint, value::Cint)::Cint
end

# typedef int yaml_read_handler_t ( void * data , unsigned char * buffer , size_t size , size_t * size_read )
"""
The prototype of a read handler.

The read handler is called when the parser needs to read more bytes from the source. The handler should write not more than *size* bytes to the *buffer*. The number of written bytes should be set to the *length* variable.

# Arguments
* `data`:\\[in,out\\] A pointer to an application data specified by [`yaml_parser_set_input`](@ref)().
* `buffer`:\\[out\\] The buffer to write the data from the source.
* `size`:\\[in\\] The size of the buffer.
* `size_read`:\\[out\\] The actual number of bytes read from the source.
# Returns
On success, the handler should return `1`. If the handler failed, the returned value should be `0`. On EOF, the handler should set the *size_read* to `0` and return `1`.
"""
const yaml_read_handler_t = Cvoid

"""
    yaml_simple_key_s

This structure holds information about a potential simple key.

| Field          | Note                       |
| :------------- | :------------------------- |
| possible       | Is a simple key possible?  |
| required       | Is a simple key required?  |
| token\\_number | The number of the token.   |
| mark           | The position mark.         |
"""
struct yaml_simple_key_s
    possible::Cint
    required::Cint
    token_number::Csize_t
    mark::yaml_mark_t
end

"""
This structure holds information about a potential simple key.
"""
const yaml_simple_key_t = yaml_simple_key_s

"""
    yaml_parser_state_e

The states of the parser.

| Enumerator                                                       | Note                                           |
| :--------------------------------------------------------------- | :--------------------------------------------- |
| YAML\\_PARSE\\_STREAM\\_START\\_STATE                            | Expect STREAM-START.                           |
| YAML\\_PARSE\\_IMPLICIT\\_DOCUMENT\\_START\\_STATE               | Expect the beginning of an implicit document.  |
| YAML\\_PARSE\\_DOCUMENT\\_START\\_STATE                          | Expect DOCUMENT-START.                         |
| YAML\\_PARSE\\_DOCUMENT\\_CONTENT\\_STATE                        | Expect the content of a document.              |
| YAML\\_PARSE\\_DOCUMENT\\_END\\_STATE                            | Expect DOCUMENT-END.                           |
| YAML\\_PARSE\\_BLOCK\\_NODE\\_STATE                              | Expect a block node.                           |
| YAML\\_PARSE\\_BLOCK\\_NODE\\_OR\\_INDENTLESS\\_SEQUENCE\\_STATE | Expect a block node or indentless sequence.    |
| YAML\\_PARSE\\_FLOW\\_NODE\\_STATE                               | Expect a flow node.                            |
| YAML\\_PARSE\\_BLOCK\\_SEQUENCE\\_FIRST\\_ENTRY\\_STATE          | Expect the first entry of a block sequence.    |
| YAML\\_PARSE\\_BLOCK\\_SEQUENCE\\_ENTRY\\_STATE                  | Expect an entry of a block sequence.           |
| YAML\\_PARSE\\_INDENTLESS\\_SEQUENCE\\_ENTRY\\_STATE             | Expect an entry of an indentless sequence.     |
| YAML\\_PARSE\\_BLOCK\\_MAPPING\\_FIRST\\_KEY\\_STATE             | Expect the first key of a block mapping.       |
| YAML\\_PARSE\\_BLOCK\\_MAPPING\\_KEY\\_STATE                     | Expect a block mapping key.                    |
| YAML\\_PARSE\\_BLOCK\\_MAPPING\\_VALUE\\_STATE                   | Expect a block mapping value.                  |
| YAML\\_PARSE\\_FLOW\\_SEQUENCE\\_FIRST\\_ENTRY\\_STATE           | Expect the first entry of a flow sequence.     |
| YAML\\_PARSE\\_FLOW\\_SEQUENCE\\_ENTRY\\_STATE                   | Expect an entry of a flow sequence.            |
| YAML\\_PARSE\\_FLOW\\_SEQUENCE\\_ENTRY\\_MAPPING\\_KEY\\_STATE   | Expect a key of an ordered mapping.            |
| YAML\\_PARSE\\_FLOW\\_SEQUENCE\\_ENTRY\\_MAPPING\\_VALUE\\_STATE | Expect a value of an ordered mapping.          |
| YAML\\_PARSE\\_FLOW\\_SEQUENCE\\_ENTRY\\_MAPPING\\_END\\_STATE   | Expect the and of an ordered mapping entry.    |
| YAML\\_PARSE\\_FLOW\\_MAPPING\\_FIRST\\_KEY\\_STATE              | Expect the first key of a flow mapping.        |
| YAML\\_PARSE\\_FLOW\\_MAPPING\\_KEY\\_STATE                      | Expect a key of a flow mapping.                |
| YAML\\_PARSE\\_FLOW\\_MAPPING\\_VALUE\\_STATE                    | Expect a value of a flow mapping.              |
| YAML\\_PARSE\\_FLOW\\_MAPPING\\_EMPTY\\_VALUE\\_STATE            | Expect an empty value of a flow mapping.       |
| YAML\\_PARSE\\_END\\_STATE                                       | Expect nothing.                                |
"""
@cenum yaml_parser_state_e::UInt32 begin
    YAML_PARSE_STREAM_START_STATE = 0
    YAML_PARSE_IMPLICIT_DOCUMENT_START_STATE = 1
    YAML_PARSE_DOCUMENT_START_STATE = 2
    YAML_PARSE_DOCUMENT_CONTENT_STATE = 3
    YAML_PARSE_DOCUMENT_END_STATE = 4
    YAML_PARSE_BLOCK_NODE_STATE = 5
    YAML_PARSE_BLOCK_NODE_OR_INDENTLESS_SEQUENCE_STATE = 6
    YAML_PARSE_FLOW_NODE_STATE = 7
    YAML_PARSE_BLOCK_SEQUENCE_FIRST_ENTRY_STATE = 8
    YAML_PARSE_BLOCK_SEQUENCE_ENTRY_STATE = 9
    YAML_PARSE_INDENTLESS_SEQUENCE_ENTRY_STATE = 10
    YAML_PARSE_BLOCK_MAPPING_FIRST_KEY_STATE = 11
    YAML_PARSE_BLOCK_MAPPING_KEY_STATE = 12
    YAML_PARSE_BLOCK_MAPPING_VALUE_STATE = 13
    YAML_PARSE_FLOW_SEQUENCE_FIRST_ENTRY_STATE = 14
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_STATE = 15
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_KEY_STATE = 16
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_VALUE_STATE = 17
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_END_STATE = 18
    YAML_PARSE_FLOW_MAPPING_FIRST_KEY_STATE = 19
    YAML_PARSE_FLOW_MAPPING_KEY_STATE = 20
    YAML_PARSE_FLOW_MAPPING_VALUE_STATE = 21
    YAML_PARSE_FLOW_MAPPING_EMPTY_VALUE_STATE = 22
    YAML_PARSE_END_STATE = 23
end

"""
The states of the parser.
"""
const yaml_parser_state_t = yaml_parser_state_e

"""
    yaml_alias_data_s

This structure holds aliases data.

| Field  | Note              |
| :----- | :---------------- |
| anchor | The anchor.       |
| index  | The node id.      |
| mark   | The anchor mark.  |
"""
struct yaml_alias_data_s
    anchor::Ptr{yaml_char_t}
    index::Cint
    mark::yaml_mark_t
end

"""
This structure holds aliases data.
"""
const yaml_alias_data_t = yaml_alias_data_s

"""
    __JL_Ctag_17

Standard (string or file) input data.
"""
struct __JL_Ctag_17
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_17}, f::Symbol)
    f === :string && return Ptr{__JL_Ctag_18}(x + 0)
    f === :file && return Ptr{Ptr{Libc.FILE}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_17, f::Symbol)
    r = Ref{__JL_Ctag_17}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_17}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_17}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
    __JL_Ctag_19

The working buffer.

| Field   | Note                                     |
| :------ | :--------------------------------------- |
| start   | The beginning of the buffer.             |
| end     | The end of the buffer.                   |
| pointer | The current position of the buffer.      |
| last    | The last filled position of the buffer.  |
"""
struct __JL_Ctag_19
    start::Ptr{yaml_char_t}
    _end::Ptr{yaml_char_t}
    pointer::Ptr{yaml_char_t}
    last::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_19}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :pointer && return Ptr{Ptr{yaml_char_t}}(x + 16)
    f === :last && return Ptr{Ptr{yaml_char_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_19, f::Symbol)
    r = Ref{__JL_Ctag_19}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_19}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_19}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_20

The raw buffer.

| Field   | Note                                     |
| :------ | :--------------------------------------- |
| start   | The beginning of the buffer.             |
| end     | The end of the buffer.                   |
| pointer | The current position of the buffer.      |
| last    | The last filled position of the buffer.  |
"""
struct __JL_Ctag_20
    start::Ptr{Cuchar}
    _end::Ptr{Cuchar}
    pointer::Ptr{Cuchar}
    last::Ptr{Cuchar}
end
function Base.getproperty(x::Ptr{__JL_Ctag_20}, f::Symbol)
    f === :start && return Ptr{Ptr{Cuchar}}(x + 0)
    f === :_end && return Ptr{Ptr{Cuchar}}(x + 8)
    f === :pointer && return Ptr{Ptr{Cuchar}}(x + 16)
    f === :last && return Ptr{Ptr{Cuchar}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_20, f::Symbol)
    r = Ref{__JL_Ctag_20}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_20}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_20}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_21

The tokens queue.

| Field | Note                                |
| :---- | :---------------------------------- |
| start | The beginning of the tokens queue.  |
| end   | The end of the tokens queue.        |
| head  | The head of the tokens queue.       |
| tail  | The tail of the tokens queue.       |
"""
struct __JL_Ctag_21
    start::Ptr{yaml_token_t}
    _end::Ptr{yaml_token_t}
    head::Ptr{yaml_token_t}
    tail::Ptr{yaml_token_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_21}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_token_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_token_t}}(x + 8)
    f === :head && return Ptr{Ptr{yaml_token_t}}(x + 16)
    f === :tail && return Ptr{Ptr{yaml_token_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_21, f::Symbol)
    r = Ref{__JL_Ctag_21}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_21}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_21}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_22

The indentation levels stack.

| Field | Note                         |
| :---- | :--------------------------- |
| start | The beginning of the stack.  |
| end   | The end of the stack.        |
| top   | The top of the stack.        |
"""
struct __JL_Ctag_22
    start::Ptr{Cint}
    _end::Ptr{Cint}
    top::Ptr{Cint}
end
function Base.getproperty(x::Ptr{__JL_Ctag_22}, f::Symbol)
    f === :start && return Ptr{Ptr{Cint}}(x + 0)
    f === :_end && return Ptr{Ptr{Cint}}(x + 8)
    f === :top && return Ptr{Ptr{Cint}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_22, f::Symbol)
    r = Ref{__JL_Ctag_22}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_22}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_22}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_23

The stack of simple keys.

| Field | Note                         |
| :---- | :--------------------------- |
| start | The beginning of the stack.  |
| end   | The end of the stack.        |
| top   | The top of the stack.        |
"""
struct __JL_Ctag_23
    start::Ptr{yaml_simple_key_t}
    _end::Ptr{yaml_simple_key_t}
    top::Ptr{yaml_simple_key_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_23}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_simple_key_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_simple_key_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_simple_key_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_23, f::Symbol)
    r = Ref{__JL_Ctag_23}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_23}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_23}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_24

The parser states stack.

| Field | Note                         |
| :---- | :--------------------------- |
| start | The beginning of the stack.  |
| end   | The end of the stack.        |
| top   | The top of the stack.        |
"""
struct __JL_Ctag_24
    start::Ptr{yaml_parser_state_t}
    _end::Ptr{yaml_parser_state_t}
    top::Ptr{yaml_parser_state_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_24}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_parser_state_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_parser_state_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_parser_state_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_24, f::Symbol)
    r = Ref{__JL_Ctag_24}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_24}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_24}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_25

The stack of marks.

| Field | Note                         |
| :---- | :--------------------------- |
| start | The beginning of the stack.  |
| end   | The end of the stack.        |
| top   | The top of the stack.        |
"""
struct __JL_Ctag_25
    start::Ptr{yaml_mark_t}
    _end::Ptr{yaml_mark_t}
    top::Ptr{yaml_mark_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_25}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_mark_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_mark_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_mark_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_25, f::Symbol)
    r = Ref{__JL_Ctag_25}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_25}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_25}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_26

The list of TAG directives.

| Field | Note                        |
| :---- | :-------------------------- |
| start | The beginning of the list.  |
| end   | The end of the list.        |
| top   | The top of the list.        |
"""
struct __JL_Ctag_26
    start::Ptr{yaml_tag_directive_t}
    _end::Ptr{yaml_tag_directive_t}
    top::Ptr{yaml_tag_directive_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_26}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_tag_directive_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_tag_directive_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_tag_directive_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_26, f::Symbol)
    r = Ref{__JL_Ctag_26}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_26}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_26}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_27

The alias data.

| Field | Note                        |
| :---- | :-------------------------- |
| start | The beginning of the list.  |
| end   | The end of the list.        |
| top   | The top of the list.        |
"""
struct __JL_Ctag_27
    start::Ptr{yaml_alias_data_t}
    _end::Ptr{yaml_alias_data_t}
    top::Ptr{yaml_alias_data_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_27}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_alias_data_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_alias_data_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_alias_data_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_27, f::Symbol)
    r = Ref{__JL_Ctag_27}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_27}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_27}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    yaml_parser_s

The parser structure.

All members are internal. Manage the structure using the `yaml_parser_` family of functions.

| Field                     | Note                                                         |
| :------------------------ | :----------------------------------------------------------- |
| error                     | Error type.                                                  |
| problem                   | Error description.                                           |
| problem\\_offset          | The byte about which the problem occured.                    |
| problem\\_value           | The problematic value (`-1` is none).                        |
| problem\\_mark            | The problem position.                                        |
| context                   | The error context.                                           |
| context\\_mark            | The context position.                                        |
| read\\_handler            | Read handler.                                                |
| read\\_handler\\_data     | A pointer for passing to the read handler.                   |
| eof                       | EOF flag                                                     |
| encoding                  | The input encoding.                                          |
| offset                    | The offset of the current position (in bytes).               |
| mark                      | The mark of the current position.                            |
| stream\\_start\\_produced | Have we started to scan the input stream?                    |
| stream\\_end\\_produced   | Have we reached the end of the input stream?                 |
| flow\\_level              | The number of unclosed '[' and '{' indicators.               |
| tokens\\_parsed           | The number of tokens fetched from the queue.                 |
| token\\_available         | Does the tokens queue contain a token ready for dequeueing.  |
| indent                    | The current indentation level.                               |
| simple\\_key\\_allowed    | May a simple key occur at the current position?              |
| state                     | The current parser state.                                    |
| document                  | The currently parsed document.                               |
"""
struct yaml_parser_s
    data::NTuple{480, UInt8}
end

function Base.getproperty(x::Ptr{yaml_parser_s}, f::Symbol)
    f === :error && return Ptr{yaml_error_type_t}(x + 0)
    f === :problem && return Ptr{Cstring}(x + 8)
    f === :problem_offset && return Ptr{Csize_t}(x + 16)
    f === :problem_value && return Ptr{Cint}(x + 24)
    f === :problem_mark && return Ptr{yaml_mark_t}(x + 32)
    f === :context && return Ptr{Cstring}(x + 56)
    f === :context_mark && return Ptr{yaml_mark_t}(x + 64)
    f === :read_handler && return Ptr{Ptr{yaml_read_handler_t}}(x + 88)
    f === :read_handler_data && return Ptr{Ptr{Cvoid}}(x + 96)
    f === :input && return Ptr{__JL_Ctag_17}(x + 104)
    f === :eof && return Ptr{Cint}(x + 128)
    f === :buffer && return Ptr{__JL_Ctag_19}(x + 136)
    f === :unread && return Ptr{Csize_t}(x + 168)
    f === :raw_buffer && return Ptr{__JL_Ctag_20}(x + 176)
    f === :encoding && return Ptr{yaml_encoding_t}(x + 208)
    f === :offset && return Ptr{Csize_t}(x + 216)
    f === :mark && return Ptr{yaml_mark_t}(x + 224)
    f === :stream_start_produced && return Ptr{Cint}(x + 248)
    f === :stream_end_produced && return Ptr{Cint}(x + 252)
    f === :flow_level && return Ptr{Cint}(x + 256)
    f === :tokens && return Ptr{__JL_Ctag_21}(x + 264)
    f === :tokens_parsed && return Ptr{Csize_t}(x + 296)
    f === :token_available && return Ptr{Cint}(x + 304)
    f === :indents && return Ptr{__JL_Ctag_22}(x + 312)
    f === :indent && return Ptr{Cint}(x + 336)
    f === :simple_key_allowed && return Ptr{Cint}(x + 340)
    f === :simple_keys && return Ptr{__JL_Ctag_23}(x + 344)
    f === :states && return Ptr{__JL_Ctag_24}(x + 368)
    f === :state && return Ptr{yaml_parser_state_t}(x + 392)
    f === :marks && return Ptr{__JL_Ctag_25}(x + 400)
    f === :tag_directives && return Ptr{__JL_Ctag_26}(x + 424)
    f === :aliases && return Ptr{__JL_Ctag_27}(x + 448)
    f === :document && return Ptr{Ptr{yaml_document_t}}(x + 472)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_parser_s, f::Symbol)
    r = Ref{yaml_parser_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_parser_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_parser_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
The parser structure.

All members are internal. Manage the structure using the `yaml_parser_` family of functions.
"""
const yaml_parser_t = yaml_parser_s

"""
    yaml_parser_initialize(parser)

Initialize a parser.

This function creates a new parser object. An application is responsible for destroying the object using the [`yaml_parser_delete`](@ref)() function.

# Arguments
* `parser`:\\[out\\] An empty parser object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_parser_initialize(parser)
    @ccall libyaml.yaml_parser_initialize(parser::Ptr{yaml_parser_t})::Cint
end

"""
    yaml_parser_delete(parser)

Destroy a parser.

# Arguments
* `parser`:\\[in,out\\] A parser object.
"""
function yaml_parser_delete(parser)
    @ccall libyaml.yaml_parser_delete(parser::Ptr{yaml_parser_t})::Cvoid
end

"""
    yaml_parser_set_input_string(parser, input, size)

Set a string input.

Note that the *input* pointer must be valid while the *parser* object exists. The application is responsible for destroing *input* after destroying the *parser*.

# Arguments
* `parser`:\\[in,out\\] A parser object.
* `input`:\\[in\\] A source data.
* `size`:\\[in\\] The length of the source data in bytes.
"""
function yaml_parser_set_input_string(parser, input, size)
    @ccall libyaml.yaml_parser_set_input_string(parser::Ptr{yaml_parser_t}, input::Ptr{Cuchar}, size::Csize_t)::Cvoid
end

"""
    yaml_parser_set_input_file(parser, file)

Set a file input.

*file* should be a file object open for reading. The application is responsible for closing the *file*.

# Arguments
* `parser`:\\[in,out\\] A parser object.
* `file`:\\[in\\] An open file.
"""
function yaml_parser_set_input_file(parser, file)
    @ccall libyaml.yaml_parser_set_input_file(parser::Ptr{yaml_parser_t}, file::Ptr{Libc.FILE})::Cvoid
end

"""
    yaml_parser_set_input(parser, handler, data)

Set a generic input handler.

# Arguments
* `parser`:\\[in,out\\] A parser object.
* `handler`:\\[in\\] A read handler.
* `data`:\\[in\\] Any application data for passing to the read handler.
"""
function yaml_parser_set_input(parser, handler, data)
    @ccall libyaml.yaml_parser_set_input(parser::Ptr{yaml_parser_t}, handler::Ptr{yaml_read_handler_t}, data::Ptr{Cvoid})::Cvoid
end

"""
    yaml_parser_set_encoding(parser, encoding)

Set the source encoding.

# Arguments
* `parser`:\\[in,out\\] A parser object.
* `encoding`:\\[in\\] The source encoding.
"""
function yaml_parser_set_encoding(parser, encoding)
    @ccall libyaml.yaml_parser_set_encoding(parser::Ptr{yaml_parser_t}, encoding::yaml_encoding_t)::Cvoid
end

"""
    yaml_parser_scan(parser, token)

Scan the input stream and produce the next token.

Call the function subsequently to produce a sequence of tokens corresponding to the input stream. The initial token has the type `YAML_STREAM_START_TOKEN` while the ending token has the type `YAML_STREAM_END_TOKEN`.

An application is responsible for freeing any buffers associated with the produced token object using the [`yaml_token_delete`](@ref) function.

An application must not alternate the calls of [`yaml_parser_scan`](@ref)() with the calls of [`yaml_parser_parse`](@ref)() or [`yaml_parser_load`](@ref)(). Doing this will break the parser.

# Arguments
* `parser`:\\[in,out\\] A parser object.
* `token`:\\[out\\] An empty token object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_parser_scan(parser, token)
    @ccall libyaml.yaml_parser_scan(parser::Ptr{yaml_parser_t}, token::Ptr{yaml_token_t})::Cint
end

"""
    yaml_parser_parse(parser, event)

Parse the input stream and produce the next parsing event.

Call the function subsequently to produce a sequence of events corresponding to the input stream. The initial event has the type `YAML_STREAM_START_EVENT` while the ending event has the type `YAML_STREAM_END_EVENT`.

An application is responsible for freeing any buffers associated with the produced event object using the [`yaml_event_delete`](@ref)() function.

An application must not alternate the calls of [`yaml_parser_parse`](@ref)() with the calls of [`yaml_parser_scan`](@ref)() or [`yaml_parser_load`](@ref)(). Doing this will break the parser.

# Arguments
* `parser`:\\[in,out\\] A parser object.
* `event`:\\[out\\] An empty event object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_parser_parse(parser, event)
    @ccall libyaml.yaml_parser_parse(parser::Ptr{yaml_parser_t}, event::Ptr{yaml_event_t})::Cint
end

"""
    yaml_parser_load(parser, document)

Parse the input stream and produce the next YAML document.

Call this function subsequently to produce a sequence of documents constituting the input stream.

If the produced document has no root node, it means that the document end has been reached.

An application is responsible for freeing any data associated with the produced document object using the [`yaml_document_delete`](@ref)() function.

An application must not alternate the calls of [`yaml_parser_load`](@ref)() with the calls of [`yaml_parser_scan`](@ref)() or [`yaml_parser_parse`](@ref)(). Doing this will break the parser.

# Arguments
* `parser`:\\[in,out\\] A parser object.
* `document`:\\[out\\] An empty document object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_parser_load(parser, document)
    @ccall libyaml.yaml_parser_load(parser::Ptr{yaml_parser_t}, document::Ptr{yaml_document_t})::Cint
end

# typedef int yaml_write_handler_t ( void * data , unsigned char * buffer , size_t size )
"""
The prototype of a write handler.

The write handler is called when the emitter needs to flush the accumulated characters to the output. The handler should write *size* bytes of the *buffer* to the output.

# Arguments
* `data`:\\[in,out\\] A pointer to an application data specified by [`yaml_emitter_set_output`](@ref)().
* `buffer`:\\[in\\] The buffer with bytes to be written.
* `size`:\\[in\\] The size of the buffer.
# Returns
On success, the handler should return `1`. If the handler failed, the returned value should be `0`.
"""
const yaml_write_handler_t = Cvoid

"""
    yaml_emitter_state_e

The emitter states.

| Enumerator                                             | Note                                                 |
| :----------------------------------------------------- | :--------------------------------------------------- |
| YAML\\_EMIT\\_STREAM\\_START\\_STATE                   | Expect STREAM-START.                                 |
| YAML\\_EMIT\\_FIRST\\_DOCUMENT\\_START\\_STATE         | Expect the first DOCUMENT-START or STREAM-END.       |
| YAML\\_EMIT\\_DOCUMENT\\_START\\_STATE                 | Expect DOCUMENT-START or STREAM-END.                 |
| YAML\\_EMIT\\_DOCUMENT\\_CONTENT\\_STATE               | Expect the content of a document.                    |
| YAML\\_EMIT\\_DOCUMENT\\_END\\_STATE                   | Expect DOCUMENT-END.                                 |
| YAML\\_EMIT\\_FLOW\\_SEQUENCE\\_FIRST\\_ITEM\\_STATE   | Expect the first item of a flow sequence.            |
| YAML\\_EMIT\\_FLOW\\_SEQUENCE\\_ITEM\\_STATE           | Expect an item of a flow sequence.                   |
| YAML\\_EMIT\\_FLOW\\_MAPPING\\_FIRST\\_KEY\\_STATE     | Expect the first key of a flow mapping.              |
| YAML\\_EMIT\\_FLOW\\_MAPPING\\_KEY\\_STATE             | Expect a key of a flow mapping.                      |
| YAML\\_EMIT\\_FLOW\\_MAPPING\\_SIMPLE\\_VALUE\\_STATE  | Expect a value for a simple key of a flow mapping.   |
| YAML\\_EMIT\\_FLOW\\_MAPPING\\_VALUE\\_STATE           | Expect a value of a flow mapping.                    |
| YAML\\_EMIT\\_BLOCK\\_SEQUENCE\\_FIRST\\_ITEM\\_STATE  | Expect the first item of a block sequence.           |
| YAML\\_EMIT\\_BLOCK\\_SEQUENCE\\_ITEM\\_STATE          | Expect an item of a block sequence.                  |
| YAML\\_EMIT\\_BLOCK\\_MAPPING\\_FIRST\\_KEY\\_STATE    | Expect the first key of a block mapping.             |
| YAML\\_EMIT\\_BLOCK\\_MAPPING\\_KEY\\_STATE            | Expect the key of a block mapping.                   |
| YAML\\_EMIT\\_BLOCK\\_MAPPING\\_SIMPLE\\_VALUE\\_STATE | Expect a value for a simple key of a block mapping.  |
| YAML\\_EMIT\\_BLOCK\\_MAPPING\\_VALUE\\_STATE          | Expect a value of a block mapping.                   |
| YAML\\_EMIT\\_END\\_STATE                              | Expect nothing.                                      |
"""
@cenum yaml_emitter_state_e::UInt32 begin
    YAML_EMIT_STREAM_START_STATE = 0
    YAML_EMIT_FIRST_DOCUMENT_START_STATE = 1
    YAML_EMIT_DOCUMENT_START_STATE = 2
    YAML_EMIT_DOCUMENT_CONTENT_STATE = 3
    YAML_EMIT_DOCUMENT_END_STATE = 4
    YAML_EMIT_FLOW_SEQUENCE_FIRST_ITEM_STATE = 5
    YAML_EMIT_FLOW_SEQUENCE_ITEM_STATE = 6
    YAML_EMIT_FLOW_MAPPING_FIRST_KEY_STATE = 7
    YAML_EMIT_FLOW_MAPPING_KEY_STATE = 8
    YAML_EMIT_FLOW_MAPPING_SIMPLE_VALUE_STATE = 9
    YAML_EMIT_FLOW_MAPPING_VALUE_STATE = 10
    YAML_EMIT_BLOCK_SEQUENCE_FIRST_ITEM_STATE = 11
    YAML_EMIT_BLOCK_SEQUENCE_ITEM_STATE = 12
    YAML_EMIT_BLOCK_MAPPING_FIRST_KEY_STATE = 13
    YAML_EMIT_BLOCK_MAPPING_KEY_STATE = 14
    YAML_EMIT_BLOCK_MAPPING_SIMPLE_VALUE_STATE = 15
    YAML_EMIT_BLOCK_MAPPING_VALUE_STATE = 16
    YAML_EMIT_END_STATE = 17
end

"""
The emitter states.
"""
const yaml_emitter_state_t = yaml_emitter_state_e

"""
    yaml_anchors_s

| Field      | Note                           |
| :--------- | :----------------------------- |
| references | The number of references.      |
| anchor     | The anchor id.                 |
| serialized | If the node has been emitted?  |
"""
struct yaml_anchors_s
    references::Cint
    anchor::Cint
    serialized::Cint
end

const yaml_anchors_t = yaml_anchors_s

"""
    __JL_Ctag_6

Standard (string or file) output data.
"""
struct __JL_Ctag_6
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_6}, f::Symbol)
    f === :string && return Ptr{__JL_Ctag_7}(x + 0)
    f === :file && return Ptr{Ptr{Libc.FILE}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_6, f::Symbol)
    r = Ref{__JL_Ctag_6}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_6}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_6}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
    __JL_Ctag_8

The working buffer.

| Field   | Note                                     |
| :------ | :--------------------------------------- |
| start   | The beginning of the buffer.             |
| end     | The end of the buffer.                   |
| pointer | The current position of the buffer.      |
| last    | The last filled position of the buffer.  |
"""
struct __JL_Ctag_8
    start::Ptr{yaml_char_t}
    _end::Ptr{yaml_char_t}
    pointer::Ptr{yaml_char_t}
    last::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_8}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :pointer && return Ptr{Ptr{yaml_char_t}}(x + 16)
    f === :last && return Ptr{Ptr{yaml_char_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_8, f::Symbol)
    r = Ref{__JL_Ctag_8}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_8}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_8}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_9

The raw buffer.

| Field   | Note                                     |
| :------ | :--------------------------------------- |
| start   | The beginning of the buffer.             |
| end     | The end of the buffer.                   |
| pointer | The current position of the buffer.      |
| last    | The last filled position of the buffer.  |
"""
struct __JL_Ctag_9
    start::Ptr{Cuchar}
    _end::Ptr{Cuchar}
    pointer::Ptr{Cuchar}
    last::Ptr{Cuchar}
end
function Base.getproperty(x::Ptr{__JL_Ctag_9}, f::Symbol)
    f === :start && return Ptr{Ptr{Cuchar}}(x + 0)
    f === :_end && return Ptr{Ptr{Cuchar}}(x + 8)
    f === :pointer && return Ptr{Ptr{Cuchar}}(x + 16)
    f === :last && return Ptr{Ptr{Cuchar}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_9, f::Symbol)
    r = Ref{__JL_Ctag_9}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_9}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_9}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_10

The stack of states.

| Field | Note                         |
| :---- | :--------------------------- |
| start | The beginning of the stack.  |
| end   | The end of the stack.        |
| top   | The top of the stack.        |
"""
struct __JL_Ctag_10
    start::Ptr{yaml_emitter_state_t}
    _end::Ptr{yaml_emitter_state_t}
    top::Ptr{yaml_emitter_state_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_10}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_emitter_state_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_emitter_state_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_emitter_state_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_10, f::Symbol)
    r = Ref{__JL_Ctag_10}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_10}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_10}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_11

The event queue.

| Field | Note                               |
| :---- | :--------------------------------- |
| start | The beginning of the event queue.  |
| end   | The end of the event queue.        |
| head  | The head of the event queue.       |
| tail  | The tail of the event queue.       |
"""
struct __JL_Ctag_11
    start::Ptr{yaml_event_t}
    _end::Ptr{yaml_event_t}
    head::Ptr{yaml_event_t}
    tail::Ptr{yaml_event_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_11}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_event_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_event_t}}(x + 8)
    f === :head && return Ptr{Ptr{yaml_event_t}}(x + 16)
    f === :tail && return Ptr{Ptr{yaml_event_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_11, f::Symbol)
    r = Ref{__JL_Ctag_11}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_11}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_11}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_12

The stack of indentation levels.

| Field | Note                         |
| :---- | :--------------------------- |
| start | The beginning of the stack.  |
| end   | The end of the stack.        |
| top   | The top of the stack.        |
"""
struct __JL_Ctag_12
    start::Ptr{Cint}
    _end::Ptr{Cint}
    top::Ptr{Cint}
end
function Base.getproperty(x::Ptr{__JL_Ctag_12}, f::Symbol)
    f === :start && return Ptr{Ptr{Cint}}(x + 0)
    f === :_end && return Ptr{Ptr{Cint}}(x + 8)
    f === :top && return Ptr{Ptr{Cint}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_12, f::Symbol)
    r = Ref{__JL_Ctag_12}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_12}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_12}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_13

The list of tag directives.

| Field | Note                        |
| :---- | :-------------------------- |
| start | The beginning of the list.  |
| end   | The end of the list.        |
| top   | The top of the list.        |
"""
struct __JL_Ctag_13
    start::Ptr{yaml_tag_directive_t}
    _end::Ptr{yaml_tag_directive_t}
    top::Ptr{yaml_tag_directive_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_13}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_tag_directive_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_tag_directive_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_tag_directive_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_13, f::Symbol)
    r = Ref{__JL_Ctag_13}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_13}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_13}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_14

Anchor analysis.

| Field           | Note                |
| :-------------- | :------------------ |
| anchor          | The anchor value.   |
| anchor\\_length | The anchor length.  |
| alias           | Is it an alias?     |
"""
struct __JL_Ctag_14
    anchor::Ptr{yaml_char_t}
    anchor_length::Csize_t
    alias::Cint
end
function Base.getproperty(x::Ptr{__JL_Ctag_14}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :anchor_length && return Ptr{Csize_t}(x + 8)
    f === :alias && return Ptr{Cint}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_14, f::Symbol)
    r = Ref{__JL_Ctag_14}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_14}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_14}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_15

Tag analysis.

| Field           | Note                    |
| :-------------- | :---------------------- |
| handle          | The tag handle.         |
| handle\\_length | The tag handle length.  |
| suffix          | The tag suffix.         |
| suffix\\_length | The tag suffix length.  |
"""
struct __JL_Ctag_15
    handle::Ptr{yaml_char_t}
    handle_length::Csize_t
    suffix::Ptr{yaml_char_t}
    suffix_length::Csize_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_15}, f::Symbol)
    f === :handle && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :handle_length && return Ptr{Csize_t}(x + 8)
    f === :suffix && return Ptr{Ptr{yaml_char_t}}(x + 16)
    f === :suffix_length && return Ptr{Csize_t}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_15, f::Symbol)
    r = Ref{__JL_Ctag_15}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_15}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_15}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_16

Scalar analysis.

| Field                     | Note                                                          |
| :------------------------ | :------------------------------------------------------------ |
| value                     | The scalar value.                                             |
| length                    | The scalar length.                                            |
| multiline                 | Does the scalar contain line breaks?                          |
| flow\\_plain\\_allowed    | Can the scalar be expessed in the flow plain style?           |
| block\\_plain\\_allowed   | Can the scalar be expressed in the block plain style?         |
| single\\_quoted\\_allowed | Can the scalar be expressed in the single quoted style?       |
| block\\_allowed           | Can the scalar be expressed in the literal or folded styles?  |
| style                     | The output style.                                             |
"""
struct __JL_Ctag_16
    value::Ptr{yaml_char_t}
    length::Csize_t
    multiline::Cint
    flow_plain_allowed::Cint
    block_plain_allowed::Cint
    single_quoted_allowed::Cint
    block_allowed::Cint
    style::yaml_scalar_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_16}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :length && return Ptr{Csize_t}(x + 8)
    f === :multiline && return Ptr{Cint}(x + 16)
    f === :flow_plain_allowed && return Ptr{Cint}(x + 20)
    f === :block_plain_allowed && return Ptr{Cint}(x + 24)
    f === :single_quoted_allowed && return Ptr{Cint}(x + 28)
    f === :block_allowed && return Ptr{Cint}(x + 32)
    f === :style && return Ptr{yaml_scalar_style_t}(x + 36)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_16, f::Symbol)
    r = Ref{__JL_Ctag_16}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_16}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_16}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    yaml_emitter_s

The emitter structure.

All members are internal. Manage the structure using the `yaml_emitter_` family of functions.

| Field                  | Note                                                                      |
| :--------------------- | :------------------------------------------------------------------------ |
| error                  | Error type.                                                               |
| problem                | Error description.                                                        |
| write\\_handler        | Write handler.                                                            |
| write\\_handler\\_data | A pointer for passing to the write handler.                               |
| encoding               | The stream encoding.                                                      |
| canonical              | If the output is in the canonical style?                                  |
| best\\_indent          | The number of indentation spaces.                                         |
| best\\_width           | The preferred width of the output lines.                                  |
| unicode                | Allow unescaped non-ASCII characters?                                     |
| line\\_break           | The preferred line break.                                                 |
| state                  | The current emitter state.                                                |
| indent                 | The current indentation level.                                            |
| flow\\_level           | The current flow level.                                                   |
| root\\_context         | Is it the document root context?                                          |
| sequence\\_context     | Is it a sequence context?                                                 |
| mapping\\_context      | Is it a mapping context?                                                  |
| simple\\_key\\_context | Is it a simple mapping key context?                                       |
| line                   | The current line.                                                         |
| column                 | The current column.                                                       |
| whitespace             | If the last character was a whitespace?                                   |
| indention              | If the last character was an indentation character (' ', '-', '?', ':')?  |
| open\\_ended           | If an explicit document end is required?                                  |
| opened                 | If the stream was already opened?                                         |
| closed                 | If the stream was already closed?                                         |
| anchors                | The information associated with the document nodes.                       |
| last\\_anchor\\_id     | The last assigned anchor id.                                              |
| document               | The currently emitted document.                                           |
"""
struct yaml_emitter_s
    data::NTuple{432, UInt8}
end

function Base.getproperty(x::Ptr{yaml_emitter_s}, f::Symbol)
    f === :error && return Ptr{yaml_error_type_t}(x + 0)
    f === :problem && return Ptr{Cstring}(x + 8)
    f === :write_handler && return Ptr{Ptr{yaml_write_handler_t}}(x + 16)
    f === :write_handler_data && return Ptr{Ptr{Cvoid}}(x + 24)
    f === :output && return Ptr{__JL_Ctag_6}(x + 32)
    f === :buffer && return Ptr{__JL_Ctag_8}(x + 56)
    f === :raw_buffer && return Ptr{__JL_Ctag_9}(x + 88)
    f === :encoding && return Ptr{yaml_encoding_t}(x + 120)
    f === :canonical && return Ptr{Cint}(x + 124)
    f === :best_indent && return Ptr{Cint}(x + 128)
    f === :best_width && return Ptr{Cint}(x + 132)
    f === :unicode && return Ptr{Cint}(x + 136)
    f === :line_break && return Ptr{yaml_break_t}(x + 140)
    f === :states && return Ptr{__JL_Ctag_10}(x + 144)
    f === :state && return Ptr{yaml_emitter_state_t}(x + 168)
    f === :events && return Ptr{__JL_Ctag_11}(x + 176)
    f === :indents && return Ptr{__JL_Ctag_12}(x + 208)
    f === :tag_directives && return Ptr{__JL_Ctag_13}(x + 232)
    f === :indent && return Ptr{Cint}(x + 256)
    f === :flow_level && return Ptr{Cint}(x + 260)
    f === :root_context && return Ptr{Cint}(x + 264)
    f === :sequence_context && return Ptr{Cint}(x + 268)
    f === :mapping_context && return Ptr{Cint}(x + 272)
    f === :simple_key_context && return Ptr{Cint}(x + 276)
    f === :line && return Ptr{Cint}(x + 280)
    f === :column && return Ptr{Cint}(x + 284)
    f === :whitespace && return Ptr{Cint}(x + 288)
    f === :indention && return Ptr{Cint}(x + 292)
    f === :open_ended && return Ptr{Cint}(x + 296)
    f === :anchor_data && return Ptr{__JL_Ctag_14}(x + 304)
    f === :tag_data && return Ptr{__JL_Ctag_15}(x + 328)
    f === :scalar_data && return Ptr{__JL_Ctag_16}(x + 360)
    f === :opened && return Ptr{Cint}(x + 400)
    f === :closed && return Ptr{Cint}(x + 404)
    f === :anchors && return Ptr{Ptr{yaml_anchors_t}}(x + 408)
    f === :last_anchor_id && return Ptr{Cint}(x + 416)
    f === :document && return Ptr{Ptr{yaml_document_t}}(x + 424)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_emitter_s, f::Symbol)
    r = Ref{yaml_emitter_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_emitter_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_emitter_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
The emitter structure.

All members are internal. Manage the structure using the `yaml_emitter_` family of functions.
"""
const yaml_emitter_t = yaml_emitter_s

"""
    yaml_emitter_initialize(emitter)

Initialize an emitter.

This function creates a new emitter object. An application is responsible for destroying the object using the [`yaml_emitter_delete`](@ref)() function.

# Arguments
* `emitter`:\\[out\\] An empty parser object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_emitter_initialize(emitter)
    @ccall libyaml.yaml_emitter_initialize(emitter::Ptr{yaml_emitter_t})::Cint
end

"""
    yaml_emitter_delete(emitter)

Destroy an emitter.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
"""
function yaml_emitter_delete(emitter)
    @ccall libyaml.yaml_emitter_delete(emitter::Ptr{yaml_emitter_t})::Cvoid
end

"""
    yaml_emitter_set_output_string(emitter, output, size, size_written)

Set a string output.

The emitter will write the output characters to the *output* buffer of the size *size*. The emitter will set *size_written* to the number of written bytes. If the buffer is smaller than required, the emitter produces the YAML\\_WRITE\\_ERROR error.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `output`:\\[in\\] An output buffer.
* `size`:\\[in\\] The buffer size.
* `size_written`:\\[in\\] The pointer to save the number of written bytes.
"""
function yaml_emitter_set_output_string(emitter, output, size, size_written)
    @ccall libyaml.yaml_emitter_set_output_string(emitter::Ptr{yaml_emitter_t}, output::Ptr{Cuchar}, size::Csize_t, size_written::Ptr{Csize_t})::Cvoid
end

"""
    yaml_emitter_set_output_file(emitter, file)

Set a file output.

*file* should be a file object open for writing. The application is responsible for closing the *file*.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `file`:\\[in\\] An open file.
"""
function yaml_emitter_set_output_file(emitter, file)
    @ccall libyaml.yaml_emitter_set_output_file(emitter::Ptr{yaml_emitter_t}, file::Ptr{Libc.FILE})::Cvoid
end

"""
    yaml_emitter_set_output(emitter, handler, data)

Set a generic output handler.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `handler`:\\[in\\] A write handler.
* `data`:\\[in\\] Any application data for passing to the write handler.
"""
function yaml_emitter_set_output(emitter, handler, data)
    @ccall libyaml.yaml_emitter_set_output(emitter::Ptr{yaml_emitter_t}, handler::Ptr{yaml_write_handler_t}, data::Ptr{Cvoid})::Cvoid
end

"""
    yaml_emitter_set_encoding(emitter, encoding)

Set the output encoding.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `encoding`:\\[in\\] The output encoding.
"""
function yaml_emitter_set_encoding(emitter, encoding)
    @ccall libyaml.yaml_emitter_set_encoding(emitter::Ptr{yaml_emitter_t}, encoding::yaml_encoding_t)::Cvoid
end

"""
    yaml_emitter_set_canonical(emitter, canonical)

Set if the output should be in the "canonical" format as in the YAML specification.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `canonical`:\\[in\\] If the output is canonical.
"""
function yaml_emitter_set_canonical(emitter, canonical)
    @ccall libyaml.yaml_emitter_set_canonical(emitter::Ptr{yaml_emitter_t}, canonical::Cint)::Cvoid
end

"""
    yaml_emitter_set_indent(emitter, indent)

Set the indentation increment.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `indent`:\\[in\\] The indentation increment (1 < . < 10).
"""
function yaml_emitter_set_indent(emitter, indent)
    @ccall libyaml.yaml_emitter_set_indent(emitter::Ptr{yaml_emitter_t}, indent::Cint)::Cvoid
end

"""
    yaml_emitter_set_width(emitter, width)

Set the preferred line width. `-1` means unlimited.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `width`:\\[in\\] The preferred line width.
"""
function yaml_emitter_set_width(emitter, width)
    @ccall libyaml.yaml_emitter_set_width(emitter::Ptr{yaml_emitter_t}, width::Cint)::Cvoid
end

"""
    yaml_emitter_set_unicode(emitter, unicode)

Set if unescaped non-ASCII characters are allowed.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `unicode`:\\[in\\] If unescaped Unicode characters are allowed.
"""
function yaml_emitter_set_unicode(emitter, unicode)
    @ccall libyaml.yaml_emitter_set_unicode(emitter::Ptr{yaml_emitter_t}, unicode::Cint)::Cvoid
end

"""
    yaml_emitter_set_break(emitter, line_break)

Set the preferred line break.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `line_break`:\\[in\\] The preferred line break.
"""
function yaml_emitter_set_break(emitter, line_break)
    @ccall libyaml.yaml_emitter_set_break(emitter::Ptr{yaml_emitter_t}, line_break::yaml_break_t)::Cvoid
end

"""
    yaml_emitter_emit(emitter, event)

Emit an event.

The event object may be generated using the [`yaml_parser_parse`](@ref)() function. The emitter takes the responsibility for the event object and destroys its content after it is emitted. The event object is destroyed even if the function fails.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `event`:\\[in,out\\] An event object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_emitter_emit(emitter, event)
    @ccall libyaml.yaml_emitter_emit(emitter::Ptr{yaml_emitter_t}, event::Ptr{yaml_event_t})::Cint
end

"""
    yaml_emitter_open(emitter)

Start a YAML stream.

This function should be used before [`yaml_emitter_dump`](@ref)() is called.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_emitter_open(emitter)
    @ccall libyaml.yaml_emitter_open(emitter::Ptr{yaml_emitter_t})::Cint
end

"""
    yaml_emitter_close(emitter)

Finish a YAML stream.

This function should be used after [`yaml_emitter_dump`](@ref)() is called.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_emitter_close(emitter)
    @ccall libyaml.yaml_emitter_close(emitter::Ptr{yaml_emitter_t})::Cint
end

"""
    yaml_emitter_dump(emitter, document)

Emit a YAML document.

The documen object may be generated using the [`yaml_parser_load`](@ref)() function or the [`yaml_document_initialize`](@ref)() function. The emitter takes the responsibility for the document object and destroys its content after it is emitted. The document object is destroyed even if the function fails.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
* `document`:\\[in,out\\] A document object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_emitter_dump(emitter, document)
    @ccall libyaml.yaml_emitter_dump(emitter::Ptr{yaml_emitter_t}, document::Ptr{yaml_document_t})::Cint
end

"""
    yaml_emitter_flush(emitter)

Flush the accumulated characters to the output.

# Arguments
* `emitter`:\\[in,out\\] An emitter object.
# Returns
`1` if the function succeeded, `0` on error.
"""
function yaml_emitter_flush(emitter)
    @ccall libyaml.yaml_emitter_flush(emitter::Ptr{yaml_emitter_t})::Cint
end

"""
    __JL_Ctag_7

String output data.

| Field          | Note                          |
| :------------- | :---------------------------- |
| buffer         | The buffer pointer.           |
| size           | The buffer size.              |
| size\\_written | The number of written bytes.  |
"""
struct __JL_Ctag_7
    buffer::Ptr{Cuchar}
    size::Csize_t
    size_written::Ptr{Csize_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_7}, f::Symbol)
    f === :buffer && return Ptr{Ptr{Cuchar}}(x + 0)
    f === :size && return Ptr{Csize_t}(x + 8)
    f === :size_written && return Ptr{Ptr{Csize_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_7, f::Symbol)
    r = Ref{__JL_Ctag_7}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_7}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_7}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_18

String input data.

| Field   | Note                          |
| :------ | :---------------------------- |
| start   | The string start pointer.     |
| end     | The string end pointer.       |
| current | The string current position.  |
"""
struct __JL_Ctag_18
    start::Ptr{Cuchar}
    _end::Ptr{Cuchar}
    current::Ptr{Cuchar}
end
function Base.getproperty(x::Ptr{__JL_Ctag_18}, f::Symbol)
    f === :start && return Ptr{Ptr{Cuchar}}(x + 0)
    f === :_end && return Ptr{Ptr{Cuchar}}(x + 8)
    f === :current && return Ptr{Ptr{Cuchar}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_18, f::Symbol)
    r = Ref{__JL_Ctag_18}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_18}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_18}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_31

The stream parameters (for `YAML_STREAM_START_EVENT`).

| Field    | Note                    |
| :------- | :---------------------- |
| encoding | The document encoding.  |
"""
struct __JL_Ctag_31
    encoding::yaml_encoding_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_31}, f::Symbol)
    f === :encoding && return Ptr{yaml_encoding_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_31, f::Symbol)
    r = Ref{__JL_Ctag_31}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_31}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_31}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_33

The list of tag directives.

| Field | Note                                       |
| :---- | :----------------------------------------- |
| start | The beginning of the tag directives list.  |
| end   | The end of the tag directives list.        |
"""
struct __JL_Ctag_33
    start::Ptr{yaml_tag_directive_t}
    _end::Ptr{yaml_tag_directive_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_33}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_tag_directive_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_tag_directive_t}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_33, f::Symbol)
    r = Ref{__JL_Ctag_33}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_33}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_33}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_32

The document parameters (for `YAML_DOCUMENT_START_EVENT`).

| Field               | Note                                 |
| :------------------ | :----------------------------------- |
| version\\_directive | The version directive.               |
| implicit            | Is the document indicator implicit?  |
"""
struct __JL_Ctag_32
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_32}, f::Symbol)
    f === :version_directive && return Ptr{Ptr{yaml_version_directive_t}}(x + 0)
    f === :tag_directives && return Ptr{__JL_Ctag_33}(x + 8)
    f === :implicit && return Ptr{Cint}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_32, f::Symbol)
    r = Ref{__JL_Ctag_32}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_32}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_32}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
    __JL_Ctag_34

The document end parameters (for `YAML_DOCUMENT_END_EVENT`).

| Field    | Note                                     |
| :------- | :--------------------------------------- |
| implicit | Is the document end indicator implicit?  |
"""
struct __JL_Ctag_34
    implicit::Cint
end
function Base.getproperty(x::Ptr{__JL_Ctag_34}, f::Symbol)
    f === :implicit && return Ptr{Cint}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_34, f::Symbol)
    r = Ref{__JL_Ctag_34}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_34}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_34}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_35

The alias parameters (for `YAML_ALIAS_EVENT`).

| Field  | Note         |
| :----- | :----------- |
| anchor | The anchor.  |
"""
struct __JL_Ctag_35
    anchor::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_35}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_35, f::Symbol)
    r = Ref{__JL_Ctag_35}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_35}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_35}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_36

The scalar parameters (for `YAML_SCALAR_EVENT`).

| Field             | Note                                          |
| :---------------- | :-------------------------------------------- |
| anchor            | The anchor.                                   |
| tag               | The tag.                                      |
| value             | The scalar value.                             |
| length            | The length of the scalar value.               |
| plain\\_implicit  | Is the tag optional for the plain style?      |
| quoted\\_implicit | Is the tag optional for any non-plain style?  |
| style             | The scalar style.                             |
"""
struct __JL_Ctag_36
    anchor::Ptr{yaml_char_t}
    tag::Ptr{yaml_char_t}
    value::Ptr{yaml_char_t}
    length::Csize_t
    plain_implicit::Cint
    quoted_implicit::Cint
    style::yaml_scalar_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_36}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :tag && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 16)
    f === :length && return Ptr{Csize_t}(x + 24)
    f === :plain_implicit && return Ptr{Cint}(x + 32)
    f === :quoted_implicit && return Ptr{Cint}(x + 36)
    f === :style && return Ptr{yaml_scalar_style_t}(x + 40)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_36, f::Symbol)
    r = Ref{__JL_Ctag_36}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_36}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_36}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_37

The sequence parameters (for `YAML_SEQUENCE_START_EVENT`).

| Field    | Note                  |
| :------- | :-------------------- |
| anchor   | The anchor.           |
| tag      | The tag.              |
| implicit | Is the tag optional?  |
| style    | The sequence style.   |
"""
struct __JL_Ctag_37
    anchor::Ptr{yaml_char_t}
    tag::Ptr{yaml_char_t}
    implicit::Cint
    style::yaml_sequence_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_37}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :tag && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :implicit && return Ptr{Cint}(x + 16)
    f === :style && return Ptr{yaml_sequence_style_t}(x + 20)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_37, f::Symbol)
    r = Ref{__JL_Ctag_37}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_37}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_37}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_38

The mapping parameters (for `YAML_MAPPING_START_EVENT`).

| Field    | Note                  |
| :------- | :-------------------- |
| anchor   | The anchor.           |
| tag      | The tag.              |
| implicit | Is the tag optional?  |
| style    | The mapping style.    |
"""
struct __JL_Ctag_38
    anchor::Ptr{yaml_char_t}
    tag::Ptr{yaml_char_t}
    implicit::Cint
    style::yaml_mapping_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_38}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :tag && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :implicit && return Ptr{Cint}(x + 16)
    f === :style && return Ptr{yaml_mapping_style_t}(x + 20)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_38, f::Symbol)
    r = Ref{__JL_Ctag_38}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_38}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_38}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_40

The scalar parameters (for `YAML_SCALAR_NODE`).

| Field  | Note                             |
| :----- | :------------------------------- |
| value  | The scalar value.                |
| length | The length of the scalar value.  |
| style  | The scalar style.                |
"""
struct __JL_Ctag_40
    value::Ptr{yaml_char_t}
    length::Csize_t
    style::yaml_scalar_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_40}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :length && return Ptr{Csize_t}(x + 8)
    f === :style && return Ptr{yaml_scalar_style_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_40, f::Symbol)
    r = Ref{__JL_Ctag_40}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_40}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_40}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_42

The stack of sequence items.

| Field | Note                         |
| :---- | :--------------------------- |
| start | The beginning of the stack.  |
| end   | The end of the stack.        |
| top   | The top of the stack.        |
"""
struct __JL_Ctag_42
    start::Ptr{yaml_node_item_t}
    _end::Ptr{yaml_node_item_t}
    top::Ptr{yaml_node_item_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_42}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_node_item_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_node_item_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_node_item_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_42, f::Symbol)
    r = Ref{__JL_Ctag_42}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_42}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_42}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_41

The sequence parameters (for `YAML_SEQUENCE_NODE`).

| Field | Note                 |
| :---- | :------------------- |
| style | The sequence style.  |
"""
struct __JL_Ctag_41
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_41}, f::Symbol)
    f === :items && return Ptr{__JL_Ctag_42}(x + 0)
    f === :style && return Ptr{yaml_sequence_style_t}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_41, f::Symbol)
    r = Ref{__JL_Ctag_41}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_41}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_41}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
    __JL_Ctag_44

The stack of mapping pairs (key, value).

| Field | Note                         |
| :---- | :--------------------------- |
| start | The beginning of the stack.  |
| end   | The end of the stack.        |
| top   | The top of the stack.        |
"""
struct __JL_Ctag_44
    start::Ptr{yaml_node_pair_t}
    _end::Ptr{yaml_node_pair_t}
    top::Ptr{yaml_node_pair_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_44}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_node_pair_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_node_pair_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_node_pair_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_44, f::Symbol)
    r = Ref{__JL_Ctag_44}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_44}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_44}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_43

The mapping parameters (for `YAML_MAPPING_NODE`).

| Field | Note                |
| :---- | :------------------ |
| style | The mapping style.  |
"""
struct __JL_Ctag_43
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_43}, f::Symbol)
    f === :pairs && return Ptr{__JL_Ctag_44}(x + 0)
    f === :style && return Ptr{yaml_mapping_style_t}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_43, f::Symbol)
    r = Ref{__JL_Ctag_43}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_43}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_43}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
    __JL_Ctag_46

The stream start (for `YAML_STREAM_START_TOKEN`).

| Field    | Note                  |
| :------- | :-------------------- |
| encoding | The stream encoding.  |
"""
struct __JL_Ctag_46
    encoding::yaml_encoding_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_46}, f::Symbol)
    f === :encoding && return Ptr{yaml_encoding_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_46, f::Symbol)
    r = Ref{__JL_Ctag_46}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_46}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_46}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_47

The alias (for `YAML_ALIAS_TOKEN`).

| Field | Note              |
| :---- | :---------------- |
| value | The alias value.  |
"""
struct __JL_Ctag_47
    value::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_47}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_47, f::Symbol)
    r = Ref{__JL_Ctag_47}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_47}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_47}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_48

The anchor (for `YAML_ANCHOR_TOKEN`).

| Field | Note               |
| :---- | :----------------- |
| value | The anchor value.  |
"""
struct __JL_Ctag_48
    value::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_48}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_48, f::Symbol)
    r = Ref{__JL_Ctag_48}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_48}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_48}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_49

The tag (for `YAML_TAG_TOKEN`).

| Field  | Note             |
| :----- | :--------------- |
| handle | The tag handle.  |
| suffix | The tag suffix.  |
"""
struct __JL_Ctag_49
    handle::Ptr{yaml_char_t}
    suffix::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_49}, f::Symbol)
    f === :handle && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :suffix && return Ptr{Ptr{yaml_char_t}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_49, f::Symbol)
    r = Ref{__JL_Ctag_49}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_49}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_49}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_50

The scalar value (for `YAML_SCALAR_TOKEN`).

| Field  | Note                             |
| :----- | :------------------------------- |
| value  | The scalar value.                |
| length | The length of the scalar value.  |
| style  | The scalar style.                |
"""
struct __JL_Ctag_50
    value::Ptr{yaml_char_t}
    length::Csize_t
    style::yaml_scalar_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_50}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :length && return Ptr{Csize_t}(x + 8)
    f === :style && return Ptr{yaml_scalar_style_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_50, f::Symbol)
    r = Ref{__JL_Ctag_50}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_50}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_50}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_51

The version directive (for `YAML_VERSION_DIRECTIVE_TOKEN`).

| Field | Note                       |
| :---- | :------------------------- |
| major | The major version number.  |
| minor | The minor version number.  |
"""
struct __JL_Ctag_51
    major::Cint
    minor::Cint
end
function Base.getproperty(x::Ptr{__JL_Ctag_51}, f::Symbol)
    f === :major && return Ptr{Cint}(x + 0)
    f === :minor && return Ptr{Cint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_51, f::Symbol)
    r = Ref{__JL_Ctag_51}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_51}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_51}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_52

The tag directive (for `YAML_TAG_DIRECTIVE_TOKEN`).

| Field  | Note             |
| :----- | :--------------- |
| handle | The tag handle.  |
| prefix | The tag prefix.  |
"""
struct __JL_Ctag_52
    handle::Ptr{yaml_char_t}
    prefix::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_52}, f::Symbol)
    f === :handle && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :prefix && return Ptr{Ptr{yaml_char_t}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_52, f::Symbol)
    r = Ref{__JL_Ctag_52}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_52}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_52}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


const YAML_NULL_TAG = "tag:yaml.org,2002:null"

const YAML_BOOL_TAG = "tag:yaml.org,2002:bool"

const YAML_STR_TAG = "tag:yaml.org,2002:str"

const YAML_INT_TAG = "tag:yaml.org,2002:int"

const YAML_FLOAT_TAG = "tag:yaml.org,2002:float"

const YAML_TIMESTAMP_TAG = "tag:yaml.org,2002:timestamp"

const YAML_SEQ_TAG = "tag:yaml.org,2002:seq"

const YAML_MAP_TAG = "tag:yaml.org,2002:map"

const YAML_DEFAULT_SCALAR_TAG = YAML_STR_TAG

const YAML_DEFAULT_SEQUENCE_TAG = YAML_SEQ_TAG

const YAML_DEFAULT_MAPPING_TAG = YAML_MAP_TAG

# exports
const PREFIXES = ["yaml", "YAML"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
