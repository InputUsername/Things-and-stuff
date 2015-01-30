class String
	def is_i?
		!!(self =~ /\A[-+]?[0-9]+\z/)
	end
end

class Fraction
	attr_accessor :n, :d
	def initialize(n, d)
		@n, @d = n, d
	end
	
	def to_s
		@n.to_s + '/' + @d.to_s
	end
end

puts '', 'Fractran interpreter 1.0', ''

file = ARGV[0]
program = ''
if file != nil and File.exists?(file) and !File.directory?(file) then
	puts 'Interpreting from file'
	program = File.read(file)
else
	puts 'Insert a program:'
	print '> '
	program = gets.chomp
end

program.gsub! /[^\d\/, ]/, ''

fractions = []

if program =~ /, / then
	fractions = program.split ', '
elsif program =~ /,/
	fractions = program.split ','
else
	fractions = program.split ' '
end

fractran = []

fractions.map do |str|
	frac = str.split '/'
	
	if frac[0].is_i? and frac[1].is_i? then
		fractran << Fraction.new(frac[0].to_i, frac[1].to_i)
	end
end

n = nil

puts 'Insert input:'
print '> '
input = gets.chomp
if input.is_i? then
	n = input.to_i
else
	abort 'Error: input must be a number'
end

i = 0

while true
	frac = (n * fractran[i].n / fractran[i].d)
	if frac.to_i == frac then
		n = frac.to_i
		i = 0
	end
	i += 1
	puts fractran.inspect
	if i == fractran.size then
		break
	end
end

puts "Result: #{n}"
