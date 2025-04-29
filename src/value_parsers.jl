const TIMESTAMP_FORMATS = [
    dateformat"yyyy-mm-dd",
    dateformat"yyyy-mm-ddTHH:MM:SS",
    dateformat"yyyy-mm-ddTHH:MM:SS.s",
    dateformat"yyyy-mm-ddTHH:MM:SS.ss",
    dateformat"yyyy-mm-ddTHH:MM:SS.sss",
]

@inline function parse_int(value)
    value = replace(value, "_" => "")
    parse(Int, value)
end

@inline function parse_float(value)
    value = replace(value, "_" => "")

    if value == ".nan" || value == ".NaN" || value == ".NAN"
        return NaN
    elseif value == ".inf" || value == ".Inf" || value == ".INF"
        return Inf
    elseif value == "-.inf" || value == "-.Inf" || value == "-.INF"
        return -Inf
    end

    return parse(Float64, value)
end

@inline parse_bool(value) = occursin(BOOL_TRUE_PATTERN, value)

@inline parse_null(value) = nothing

@inline function parse_timestamp(value)
    for fmt in TIMESTAMP_FORMATS
        try
            return DateTime(value, fmt)
        catch
            continue
        end
    end

    throw(YAMLError("Unrecognized timestamp format: $value"))
end
