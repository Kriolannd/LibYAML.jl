using Test, LibYAML, Dates

@testset "[1] Basic YAML parsing" begin
    yaml = """
    foo: bar
    baz: 42
    """
    parsed = (parse_yaml(yaml))[1]
    @test parsed["foo"] == "bar"
    @test parsed["baz"] == 42
end

@testset "[2] Types: Int, Float, Bool, Null, Timestamp" begin
    yaml = """
    int: 42
    float: 3.14
    bool1: true
    bool2: OFF
    null1: null
    null2: ~
    null3:
    date: 2020-12-30
    datetime: 2020-12-30T12:34:56.123Z
    """
    parsed = (parse_yaml(yaml))[1]
    @test parsed["int"] == 42
    @test parsed["float"] ≈ 3.14
    @test parsed["bool1"] == true
    @test parsed["bool2"] == false
    @test isnothing(parsed["null1"])
    @test isnothing(parsed["null2"])
    @test isnothing(parsed["null3"])
    @test parsed["date"] == Date("2020-12-30")
    @test parsed["datetime"] == DateTime("2020-12-30T12:34:56.123")
end

@testset "[3] Lists and Dicts" begin
    yaml = """
    list:
      - one
      - 2
      - true
    dict:
      foo: bar
      baz: 123
    nested:
      - key1: val1
        key2: val2
    """
    parsed = (parse_yaml(yaml))[1]
    @test parsed["list"] == ["one", 2, true]
    @test parsed["dict"] == Dict("foo" => "bar", "baz" => 123)
    @test parsed["nested"][1]["key1"] == "val1"
end

@testset "[4] Multiply nested case" begin
    # Nested mapping
    nested_yaml = """
    a:
      b:
        c:
          d:
            e: value
    """
    parsed = parse_yaml(nested_yaml)[1]
    @test parsed["a"]["b"]["c"]["d"]["e"] == "value"

    # Nested sequence
    nested_yaml = """
    nested:
      - - 1
        - 2
      - - 3
        - 4
    """
    parsed = parse_yaml(nested_yaml)[1]
    @test parsed == Dict("nested" => [[1,2],[3,4]])
end

@testset "[5] Merge case" begin
    # Merge with one dict
    merge_yaml = """
    base: &base
      name: base
      value: 10

    merged:
      <<: *base
      extra: true
    """
    parsed = parse_yaml(merge_yaml)[1]
    @test parsed["merged"] == Dict("name" => "base", "value" => 10, "extra" => true)
    @test parsed["base"] == Dict("name" => "base", "value" => 10)

    # Merge with multiple dict
    multi_merge_yaml = """
    default: &default
      x: 1
    override: &override
      y: 2
    combined:
      <<: [*default, *override]
      z: 3
    """
    parsed = parse_yaml(multi_merge_yaml)[1]
    @test parsed["combined"] == Dict("x" => 1, "y" => 2, "z" => 3)
    @test parsed["default"] == Dict("x" => 1)
    @test parsed["override"] == Dict("y" => 2)

    # Nested merge
    nested_merge = """
    defaults: &defaults
      val: 1

    inner: &inner
      <<: *defaults
      inner_val: 2

    outer:
      <<: *inner
      outer_val: 3
    """
    parsed = parse_yaml(nested_merge)[1]
    @test parsed["outer"] == Dict("val" => 1, "inner_val" => 2, "outer_val" => 3)
    @test parsed["inner"] == Dict("val" => 1, "inner_val" => 2)
    @test parsed["defaults"] == Dict("val" => 1)
end

@testset "[6] Edge cases" begin
    @test isempty(parse_yaml(""))
    @test parse_yaml("---") == [nothing]
    @test (parse_yaml("empty_list: []"))[1] == Dict("empty_list" => [])
    @test (parse_yaml("empty_dict: {}"))[1] == Dict("empty_dict" => Dict())
    @test (parse_yaml("utf8: 😀"))[1] == Dict("utf8" => "😀")
end

@testset "[7] Aliases without merge" begin
    yaml = """
    default: &default
      key: val
    copy1: *default
    copy2: *default
    """
    parsed = parse_yaml(yaml)[1]
    @test parsed["default"] == Dict("key" => "val")
    @test parsed["copy1"] == Dict("key" => "val")
    @test parsed["copy2"] == Dict("key" => "val")
end

@testset "[8] Multiple documents" begin
    yaml = """
    ---
    a: 1
    ---
    b: 2
    ...
    ---
    c: 3
    """
    parsed = parse_yaml(yaml)
    @test length(parsed) == 3
    @test parsed[1] == Dict("a" => 1)
    @test parsed[2] == Dict("b" => 2)
    @test parsed[3] == Dict("c" => 3)
end

@testset "[9] Multiline strings" begin
    yaml = """
    folded: >
      This is
      folded
      text.
    literal: |
      This is
      literal
      text.
    """
    parsed = parse_yaml(yaml)[1]
    @test parsed["folded"] == "This is folded text.\n"
    @test parsed["literal"] == "This is\nliteral\ntext.\n"
end

@testset "[10] Quoted strings and escape sequences" begin
    yaml = """
    single: 'I''m single-quoted'
    double: "Line\\nBreak"
    special: "\\u263A"
    """
    parsed = parse_yaml(yaml)[1]
    @test parsed["single"] == "I'm single-quoted"
    @test parsed["double"] == "Line\nBreak"
    @test parsed["special"] == "☺"
end

@testset "[11] Real YAML error triggering" begin
    # READER ERROR
    @test_throws YAMLReaderError parse_yaml("\xff")

    # SCANNER ERROR
    @test_throws YAMLScannerError parse_yaml("""
    key: "unterminated
    """)

    # PARSER ERROR
    @test_throws YAMLParserError parse_yaml("""
    a:
      - b
    - c  # неправильный отступ
    """)

    # YAMLError
    @test_throws YAMLError parse_yaml("""
    key: !include not_exist.yaml
    """)
end

@testset "[13] Read from YAML file and include" begin
  mktempdir() do dir
      configs_path = mkdir(joinpath(dir, "configs"))

      services_path = joinpath(configs_path, "services.yaml")
      services_yaml = """
      - name: auth
        port: 8080
      - name: billing
        port: 8081
      """
      write(services_path, services_yaml)

      database_path = joinpath(configs_path, "database.yaml")
      database_yaml = """
      host: localhost
      port: 5432
      username: admin
      password: secret
      """
      write(database_path, database_yaml)

      main_path = joinpath(dir, "main.yaml")
      main_yaml = """
      database: !include configs/database.yaml
      services: !include configs/services.yaml
      """
      write(main_path, main_yaml)

      parsed = (open_yaml(main_path))[1]

      @test parsed["database"]["host"] == "localhost"
      @test parsed["database"]["port"] == 5432
      @test parsed["database"]["username"] == "admin"
      @test parsed["database"]["password"] == "secret"

      @test parsed["services"][1]["name"] == "auth"
      @test parsed["services"][1]["port"] == 8080
      @test parsed["services"][2]["name"] == "billing"
      @test parsed["services"][2]["port"] == 8081
  end
end
