# Unnecessary interpreter
# Written by InputUsername

#Parameter checking
if ARGV.size < 1 then
	puts 'Usage:'
	puts '   ruby unneccessary.rb [parameters] filename',''
	puts 'Supported parameters:'
	puts '   -d     Shows debug information'
	puts '   -c     Compile instead of interpreting'
	exit true
end

debug,compile,file = false,false,''
ARGV.each{|a|
	case a
	when '-d'
		debug = true
	when '-c'
		compile = true
	else
		file = a
	end
}

#File checking
if file.eql?'' then
	abort 'Error: no file name given!'
end
if File.exists? file then
	abort 'Error: file exists!'
end

#Compiling/interpreting
if compile then
	puts 'Compiling the program...' if debug
	#This currently does nothing
else
	if debug then
		puts 'Debug: starting execution'
		puts 'Debug: finished execution'
	end
	puts 'Program executed perfectly right!'
end