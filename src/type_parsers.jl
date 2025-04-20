@inline function parse_int(value)
    value = lowercase(replace(value, "_" => ""))
    parse(Int, value)
end

@inline function parse_float(value)
    value = lowercase(replace(value, "_" => ""))

    value == ".nan" && return NaN

    m = match(r"^([+\-]?)\.inf$", value)
    if m !== nothing
        if m.captures[1] == "-"
            return -Inf
        else
            return Inf
        end
    end

    return parse(Float64, value)
end

@inline parse_bool(value) = occursin(BOOL_TRUE_PATTERN, value)

@inline parse_null(value) = nothing

@inline function parse_timestamp(value)
    timestamp_pattern = RESOLVERS[YAML_TIMESTAMP_TAG]

    mat = match(timestamp_pattern, value)

    year = parse(Int, mat.captures[1])
    month = parse(Int, mat.captures[2])
    day = parse(Int, mat.captures[3])

    if mat.captures[4] === nothing
        return Date(year, month, day)
    end

    hour = parse(Int, mat.captures[4])
    min = parse(Int, mat.captures[5])
    sec = parse(Int, mat.captures[6])

    if mat.captures[7] === nothing
        return DateTime(year, month, day, hour, min, sec)
    end

    ms = 0
    if mat.captures[7] !== nothing
        ms = mat.captures[7]
        if length(ms) > 3
            ms = ms[1:3]
        end
        ms = parse(Int, string(ms, repeat("0", 3 - length(ms))))
    end

    delta_hr = 0
    delta_mn = 0

    if mat.captures[9] !== nothing
        delta_hr = parse(Int, mat.captures[9])
    end

    if mat.captures[10] !== nothing
        delta_mn = parse(Int, mat.captures[10])
    end

    return DateTime(year, month, day, hour, min, sec, ms)
end

@inline function parse_include(rel_path::String, file_dir)
    path = joinpath(file_dir, rel_path)
    isfile(path) || throw(YAMLError("File not found: $path"))

    included_yaml = read(path)
    included_docs = parse_yaml_str(included_yaml, dirname(path))
    length(included_docs) == 1 || throw(YAMLError("Expected a single-document YAML file"))

    return included_docs[1]
end
