module QQ
  # A simple shell thing, only scans/parses input
  def self.scanner_shell
    while true
      print '> '
      input = STDIN.gets.chomp

      break if ['exit', 'quit', 'e', 'q'].include?(input)

      begin
        result = scan_parse(input)
        result = '--> ' + result.to_s
      rescue Exception => e
        result = "--> Parse error in '#{result}' - #{e.message}"
      end

      puts result, ''
    end
  end

  # Another simple shell thing, scans/parses + interprets input
  def self.interpreter_shell
    while true
      print '> '
      input = STDIN.gets.chomp

      break if ['exit', 'quit', 'e', 'q'].include?(input)

      puts '-> Scanning/parsing'

      result = input
      begin
        result = scan_parse(input)
      rescue Exception => e
        result = "-> Parse error in '#{result}' - #{e.message}"
      end

      next if result.is_a?(String)

      puts '-> Interpreting'

      begin
        result = interpret(result, true)
        result = '--> ' + result
      rescue Exception => e
        result = '--> Interpret error - ' + e.message
      end

      puts result, ''
    end
  end
end
