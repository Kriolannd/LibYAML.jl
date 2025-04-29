# LibYAML.jl 

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Kriolannd.github.io/LibYAML.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Kriolannd.github.io/LibYAML.jl/dev/)
[![Build Status](https://github.com/Kriolannd/LibYAML.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/Kriolannd/LibYAML.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/Kriolannd/LibYAML.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Kriolannd/LibYAML.jl)
[![Registry](https://img.shields.io/badge/registry-General-4063d8)](https://github.com/JuliaRegistries/General)

Julia wrapper package for parsing `yaml` files

## Installation

To install LibYAML, simply use the Julia package manager:

```julia
] add LibYAML
```

## Usage
```julia
using LibYAML

yaml_str = """
retCode: 0
retMsg: "OK"
result:
  ap: 0.6636
  bp: 0.6634
  h: 0.6687
  l: 0.6315
  lp: 0.6633
  o: 0.6337
  qv: 1.1594252877069e7
  s: "ADAUSDT"
  t: "2024-03-25T19:05:35.491"
  v: 1.780835204e7
retExtInfo: {}
time: "2024-03-25T19:05:38.912"
"""

julia> parse_yaml(yaml_str)
1-element Vector{Dict{Any, Any}}:
 Dict(
  "retExtInfo" => Dict{String, Any}(),
  "time" => DateTime("2024-03-25T19:05:38.912"),
  "retCode" => 0,
  "retMsg" => "OK",
  "result" => Dict{String, Any}("v" => 1.780835204e7, "ap" => 0.6636, "o" => 0.6337, "t" => DateTime("2024-03-25T19:05:35.491"), "qv" => 1.1594252877069e7, "bp" => 0.6634, "l" => 0.6315, "lp" => 0.6633, "h" => 0.6687, "s" => "ADAUSDT"…))
```

## Useful Links

- [libyaml](https://github.com/yaml/libyaml) – Official library repository.  
- [LibYAML_jll.jl](https://github.com/JuliaBinaryWrappers/LibYAML_jll.jl) – Julia wrapper for libyaml.

## Contributing

Contributions to LibYAML are welcome! If you encounter a bug, have a feature request, or would like to contribute code, please open an issue or a pull request on GitHub.
