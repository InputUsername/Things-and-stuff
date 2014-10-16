# Poop 1.0 interpreter
# By InputUsername

#Parameter checking
if ARGV.size < 1 then
	puts 'Usage:'
	puts '   ruby unneccessary.rb [parameters] filename',''
	puts 'Supported parameters:'
	puts '   -d     Shows debug information'
	exit true
end

debug,file = false,''
ARGV.each{|a|
	case a
	when '-d'
		debug = true
	else
		file = a
	end
}

puts 'Debug: checking the file' if debug

#File checking
if file.eql?'' then
	abort 'Error: no filename given!'
elsif !File.exists? file then
	abort 'Error: file doesn\'t exist!'
end

puts 'Debug: starting execution' if debug

#Interpreting
charptr,str,characters = 0,'',"0123456789abcdefghijklmnopqrstuvwxyz.,-!?+*<>#@$`\u00A7%&/()[]".encode('utf-8').chars.to_a
contents = File.read(file).gsub('/[\n\t]/','\s').split ' '

contents.each {|cmd|
	case cmd
	when 'eat'
		charptr += 1
	when 'puke'
		charptr -= 1
	when 'poop'
		str += characters[charptr]
	when 'POOP'
		str += characters[charptr].upcase
	when 'sniff'
		puts str
	when 'flush'
		str = ''
		charptr = 0
	else
		puts('Debug: encountered illegal command ('+cmd+')')
	end
	charptr %= characters.size
}

puts 'Debug: finished execution' if debug