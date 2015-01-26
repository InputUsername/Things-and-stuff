# Ruby qq interpreter
# (c) 2015 InputUsername

path = File.dirname(__FILE__) + File::SEPARATOR
require path + 'lib.rb'
require path + 'shell.rb'

USAGE = %q(Usage:

  ruby ./qq.rb [file]
)

file = ARGV[0]

if !file then
  puts 'Interactive qq shell', 'Use exit/quit/e/q to quit.'
  QQ.interpreter_shell
else
  if !File.exists?(file) then
    abort 'File does not exist'
  elsif File.directory?(file) then
    abort 'File is a directory'
  end

  content = File.read(file)
  if !content or content == '' then
    abort 'Empty file'
  end

  begin
    result = QQ.scan_parse(content)
  rescue Exception => e
    abort "Parse error: #{e.message}"
  end

  begin
    result = QQ.interpret(result, true)
  rescue Exception => e
    abort "Interpret error: #{e.message}"
  end

  puts result
end
