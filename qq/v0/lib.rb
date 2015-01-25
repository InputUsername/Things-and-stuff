require 'io/console'

module QQ
  # Utilities
  def self.is_int?(val)
    val.is_a?(Fixnum)
  end
  def self.is_quoted?(val)
    val.is_a?(Array)
  end

  # Scan the code and turn it into an Array
  def self.scan_parse(code)
    if code.count('(') != code.count(')') then
      raise 'unmatched parentheses'
    elsif code =~ /[^\(\)0-9\s]/ then
      raise 'illegal characters'
    elsif code =~ /\(\)/ then
      raise 'illegal parenthesis sequence'
    end

    code = code.strip
    .gsub(/ +/, ' ')
    .gsub(/\(/, '[')
    .gsub(/\)/, ']')
    .gsub(/([0-9]+)/, '\1,')
    .gsub(/\]\s*\[/, '],[')

    if code.include?('],[') then
      code = "[#{code}]"
    end

    return eval(code)
  end

  # Interpret a scanned/parsed code Array
  # top_level must only be true if called from the top-level program
  def self.interpret(code_array, top_level = false)
    return_value = nil
    cmd = code_array[0]
    arg = code_array[1..-1]

    # If the entire code array contains only arrays,
    # then apparently the program consisted of multiple quoted expressions.
    # Evaluate all expressions and return the last-evaluated expression.
    only_arrays = code_array.all? {|x| x.is_a?(Array)}
    if top_level and only_arrays then
      code_array.each do |expr|
        return_value = interpret(expr)
      end
      return return_value
    end

    raise 'command must be integer' if !is_int?(cmd)

    case cmd

      # Return (arg1 [int] rest_of_args) evaluated
    when 0
      raise 'arg:1 of cmd:0 must be integer' if !is_int?(arg[0])

      new_cmd = arg[0]
      new_arg = arg[1..-1]
      new_arg.map! {|a| is_quoted?(a) ? interpret(a) : a }
      return_value = interpret(new_cmd << new_arg)

      # Return arg:1
    when 1
      return_value = arg[0]

      # Return arg:1 [quoted] and arg:2 [quoted], concatenated together
    when 2
      raise 'arg:1 of cmd:2 must be quoted' if !is_quoted?(arg[0])
      raise 'arg:2 of cmd:2 must be quoted' if !is_quoted?(arg[1])

      return_value = arg[0] << arg[1]

      # Return arg:1 [quoted] concatenated with itself
    when 3
      raise 'arg:1 of cmd:3 must be quoted' if !is_quoted?(arg[0])

      return_value = arg[0] << arg[0]

      # Return arg:1 [int] + arg:2 [int]
    when 4
      raise 'arg:1 of cmd:4 must be integer' if !is_int(arg[0])
      raise 'arg:2 of cmd:4 must be integer' if !is_int(arg[1])

      return_value = arg[0] + arg[1]

      # Return arg:1 - arg:2; if a negative value results, return arg:1 + arg:2
    when 5
      raise 'arg:1 of cmd:5 must be integer' if !is_int(arg[0])
      raise 'arg:2 of cmd:5 must be integer' if !is_int(arg[1])

      return_value = arg[0] - arg[1]
      if return_value < 0 then
        return_value = arg[0] + arg[1]
      end

      # Return the ASCII value of a single input character
    when 6
      return_value = STDIN.getch.ord

      # Print the ASCII character represented by arg:1 and return arg:1
    when 7
      raise 'arg:1 of cmd:7 must be integer' if !is_int(arg[0])

      print arg[0].chr
      return_value = arg[0]

      # Return arg:3 if arg:1 is 0, else return arg:1
    when 8
      return_value = (arg[0] == 0 ? arg[2] : arg[1])

      # ???
    when 9
      raise 'arg:1 of cmd:9 must be an integer' if !is_int(arg[0])
      # Instructions unclear. Will attempt later.

    end

    return_value
  end
end
