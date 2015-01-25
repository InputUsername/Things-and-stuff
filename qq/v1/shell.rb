module QQ
  class Shell
    def initialize(type = :interpret)
      type = :interpret unless [:parse, :interpret].include?(type)
      @type = type
    end

    def start
      case @type
      when :parse; parse_shell
      when :interpret; interpret_shell
      end
    end

    # A simple shell that only parses input and displays the result
    def parse_shell
      while true
        print '> '
        input = STDIN.gets.chomp

        break if ['exit', 'e', 'quit', 'q'].include?(input.downcase)

        # Parse
        begin
          parsed = QQ::Lang.scan_parse(input)
        rescue Exception => e
          puts '=> Parse Error: ' + e.message
          e.backtrace.each {|t| puts "   #{t.inspect}" }
          puts
          next
        end

        puts '=> ' + parsed.to_s, ''
      end
    end

    # Another simple shell that parses and evaluates input
    def interpret_shell
      while true
        print '> '
        input = STDIN.gets.chomp

        break if ['exit', 'e', 'quit', 'q'].include?(input.downcase)

        # Parse
        begin
          parsed = QQ::Lang.scan_parse(input)
        rescue Exception => e
          puts '=> Parse Error: ' + e.message
          e.backtrace.each {|t| puts "   #{t.inspect}" }
          puts
          next
        end

        puts '=> ' + parsed.to_s, ''

        # Interpret
        begin
          result = QQ::Lang.interpret(parsed)
        rescue Exception => e
          puts '=> Interpret Error: ' + e.message
          e.backtrace.each {|t| puts "   #{t.inspect}" }
          puts
          next
        end

        puts '=> ' + result.to_s, ''
      end
    end

    private :parse_shell, :interpret_shell
  end
end
