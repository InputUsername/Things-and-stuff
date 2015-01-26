require 'io/console'

#TODO: correctly implement generated commands (they don't work as integers yet)
#TODO: correctly evaluate generated commands

module QQ
  class Lang
    RANDOM_SEED = rand(0..15)

    def self.is_quoted?(val); val.is_a?(Array) and val[0] == :quoted; end
    def self.is_generated?(val); val.is_a?(Array) and val[0] == :generated; end
    def self.is_int?(val); val.is_a?(Fixnum) or self.is_generated?(val); end

    def self.generated_to_i(val)
        return if !self.is_generated?(val)
        return val.size * RANDOM_SEED
    end

    ## BNF of qq:
    # program    := <expression>*
    # expression := '(' <expression>+ ')'
    # expression := <integer>
    # integer    := [0-9]+
    ##

    def self.scan_parse(code)
      # Split the code, to check it for errors
      chars = code.split('')

      # Count nested parentheses
      p_match = 0
      p_indices = []

      # Current character's index, used inside chars.each
      index = 0

      chars.each do |c|
        # Illegal characters
        if c =~ /[^\(\)\d\s]/ then
          raise "illegal token at #{index} : #{c}"
        end

        # Empty parentheses
        if index != (chars.size - 1) and chars[index..(index+1)] == ['(',')'] then
          raise "empty parentheses at #{index}"
        end

        if c == '(' then
          p_match += 1
          p_indices << index
        elsif c == ')'
          p_match -= 1
          p_indices.pop unless p_indices.empty?
        end

        index += 1
      end

      if p_match != 0 then
        raise "unmatched parenthesis at #{p_indices.last}"
      end

      code = code.strip
        .gsub(/[\n\t]/, '')
        .gsub(/ +/, ' ')
        .gsub(/\(/, '[')
        .gsub(/\)/, ']')
        .gsub(/(\d+)/, '\1,')
        .gsub(/\]/, '],')
        .gsub(/\[\s*(\d)/, '[:quoted,\1')

      code = '[:program,' + code + ']'

      code = eval(code)
    end

    def self.interpret(code_array)
      if code_array[0] == :program then
        return_value = nil
        expressions = code_array[1..-1]
        expressions.each do |expr|
          return_value = QQ::Lang.interpret(expr)
        end
        return return_value
      end

      if !QQ::Lang.is_quoted?(code_array) and !QQ::Lang.is_generated?(code_array) then
        raise 'unknown error'
      end

      return_value = nil
      cmd = code_array[1]
      arg = code_array[2..-1]

      #DEBUG
      #puts 'debug:cmd='+cmd.to_s
      #puts 'debug:arg='+(arg.inspect)

      case cmd

      # Evaluate arg:1 [int], using the evaluated form of the rest of the arguments
      # as the arguments for the new command
      when 0
        raise "arg:1 of cmd:0 must be integer (got #{arg[0]})" if !QQ::Lang.is_int?(arg[0])

        # Convert arg[0] to an integer if it's a generated command
        #arg[0] = QQ::Lang.generated_to_i(arg[0]) if QQ::Lang.is_generated?(arg[0])

        new_cmd = arg[0]
        new_arg = arg[1..-1]
        new_arg.map! {|a| QQ::Lang.is_quoted?(a) ? interpret(a) : a }

        #DEBUG
        #puts 'debug:0_newarg='+(new_arg.inspect)

        return_value = QQ::Lang.interpret([:quoted, new_cmd] + new_arg)

      # Return arg:1, not evaluated
      when 1
        return_value = arg[0]

      # Concatenate arg:1 [quoted] with arg:2 [quoted] appended to it
      when 2
        raise "arg:1 of cmd:2 must be quoted (got #{arg[0]})" if !QQ::Lang.is_quoted?(arg[0])
        raise "arg:2 of cmd:2 must be quoted (got #{arg[1]})" if !QQ::Lang.is_quoted?(arg[1])

        return_value = arg[0] << arg[1][1..-1]

      # Concatenate arg:1 [quoted] with itself
      when 3
        raise "arg:1 of cmd:3 must be quoted (got #{arg[0]})" if !QQ::Lang.is_quoted?(arg[0])

        return_value = arg[0] << arg[0][1..-1]

      # Return arg:1 [int] + arg:2 [int]
      when 4
        raise "arg:1 of cmd:4 must be integer (got #{arg[0]})" if !QQ::Lang.is_int?(arg[0])
        raise "arg:2 of cmd:4 must be integer (got #{arg[1]})" if !QQ::Lang.is_int?(arg[1])

        # Convert to int
        arg[0] = QQ::Lang.generated_to_i(arg[0]) if QQ::Lang.is_generated?(arg[0])
        arg[1] = QQ::Lang.generated_to_i(arg[1]) if QQ::Lang.is_generated?(arg[1])

        return_value = arg[0] + arg[1]

      # Return arg:1 [int] - arg:2 [int] - if the result is negative, add them instead
      when 5
        raise "arg:1 of cmd:5 must be integer (got #{arg[0]})" if !QQ::Lang.is_int?(arg[0])
        raise "arg:2 of cmd:5 must be integer (got #{arg[1]})" if !QQ::Lang.is_int?(arg[1])

        # Convert to int
        arg[0] = QQ::Lang.generated_to_i(arg[0]) if QQ::Lang.is_generated?(arg[0])
        arg[1] = QQ::Lang.generated_to_i(arg[1]) if QQ::Lang.is_generated?(arg[1])

        return_value = arg[0] - arg[1]
        if return_value < 0 then
          return_value = arg[0] + arg[1]
        end

      # Return the ASCII value of a single character from standard input
      when 6
        return_value = STDIN.getch.ord

      # Print the character represented by arg:1 [int] and return it
      when 7
        raise "arg:1 of cmd:7 must be integer (got #{arg[0]})" if !QQ::Lang.is_int?(arg[0])

        # Convert to int
        # See TODO at top
        arg[0] = QQ::Lang.generated_to_i(arg[0]) if QQ::Lang.is_generated?(arg[0])

        print arg[0].chr
        return_value = arg[0]

      # If arg:1 is not zero, return arg:2, else return arg:3
      when 8

        # Convert to int
        # TODO: fix
        arg[0] = QQ::Lang.generated_to_i(arg[0]) if QQ::Lang.is_generated?(arg[0])

        return_value = (arg[0] == 0 ? arg[2] : arg[1])

      # Very complicated stuff, command creation shit
      when 9
        raise "arg:1 of cmd:9 must be integer (got #{arg[0]})" if !QQ::Lang.is_int?(arg[0])

        # Convert to int
        # TODO: copy code to here

        generated = [:generated] + arg
        return_value = generated


      # Either a generated command or an illegal command
      else
        if QQ::Lang.is_generated?(cmd) then
          new_cmd = cmd[1]
          new_arg = cmd[2..-1]
          new_quoted = [:quoted, new_cmd] + new_arg + arg

          return_value = interpret(new_quoted)
        else
          raise "unknown command #{cmd.to_s}"
        end

      end

      #DEBUG
      #puts 'debug:'+cmd.to_s+'_ret='+return_value.to_s

      return return_value
    end
  end
end
