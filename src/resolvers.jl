const EXPLICIT_TYPES_TAGS = [
    "!include",
    YAML_BOOL_TAG,
    YAML_INT_TAG,
    YAML_FLOAT_TAG,
    YAML_NULL_TAG,
    YAML_TIMESTAMP_TAG,
]

const YAML_DEFAULT_SCALAR_TAG = YAML_STR_TAG
const BOOL_TRUE_PATTERN = r"^(?:y|Y|yes|Yes|YES|true|True|TRUE|on|On|ON)$"x

const RESOLVERS = Dict{String, Regex}(
    YAML_BOOL_TAG => r"^(?:y|Y|yes|Yes|YES|n|N|no|No|NO
                        |true|True|TRUE|false|False|FALSE
                        |on|On|ON|off|Off|OFF)$"x,
    YAML_INT_TAG => r"^(?:[-+]? [0-9]+)$"x,
    YAML_FLOAT_TAG => r"^(?:[-+]? ( \. [0-9]+ 
                        | [0-9]+ ( \. [0-9]* )? ) ( [eE] [-+]? [0-9]+ )?
                        |[-+]? (?: \.inf | \.Inf | \.INF )
                        |\.nan | \.NaN | \.NAN)$"x,
    YAML_NULL_TAG => r"^(?:~|null|Null|NULL|)$"x,
    YAML_TIMESTAMP_TAG => r"^(\d{4})-    (?# year)
                             (\d\d?)-    (?# month)
                             (\d\d?)     (?# day)
                            (?:
                             (?:[Tt]|[ \t]+)
                             (\d\d?):      (?# hour)
                             (\d\d):       (?# minute)
                             (\d\d)        (?# second)
                             (?:\.(\d*))?  (?# fraction)
                             (?:
                               [ \t]*(Z|([+\-])(\d\d?)
                               (?:
                                    :(\d\d)
                               )?)
                             )?
                            )?$"x,
)

function resolve(value, tag)
    tag in EXPLICIT_TYPES_TAGS && return tag
    
    for (tag, reg) in RESOLVERS
        occursin(reg, value) && return tag
    end

    return YAML_DEFAULT_SCALAR_TAG
end
