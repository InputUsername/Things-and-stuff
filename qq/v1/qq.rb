# qq interpreter by InputUsername

require_relative 'core'
require_relative 'shell'

USAGE = "Usage:

  qq <file | flag>

Options:
  -p or --parse     : Enter a parse-only interactive shell
  -i or --interpret : Enter an interactive shell
  -h or --help      : Show usage
"

flag = ARGV[0]

if !flag or ['-h', '--help'].include?(flag) then
  abort(USAGE)
end

# Parse-only shell
if ['-p', '--parse'].include?(flag) then
  puts '## qq parse-only interactive shell', '## use exit/quit/e/q to quit'
  QQ::Shell.new(:parse).start
  exit

# Interpret shell
elsif ['-i', '--interpret'].include?(flag) then
  puts '## qq interactive shell', '## use exit/quit/e/q to quit'
  QQ::Shell.new(:interpret).start
  exit
end

# Interpret file
file = ARGV[0]

if !File.exists?(file) then
  abort 'File does not exist'
elsif File.directory?(file) then
  abort 'File is a directory'
end

code = File.read(file)
begin
  parsed = QQ::Lang.scan_parse(code)
rescue Exception => e
  abort "Parse Error: #{e.message}"
end

begin
  result = QQ::Lang.interpret(parsed)
rescue Exception => e
  abort "Interpret Error: #{e.message}"
end
