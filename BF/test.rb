require 'babel_bridge'
require 'io/console'

#apparently this doesn't work

=begin
class BFParser < BabelBridge::Parser
	ignore_whitespace
	
	def tape
		@tape ||= []
	end
	def ptr
		@ptr ||= 0
	end
	
	rule :program, many?(:instruction)
	
	rule :instruction, any('>', '<', '+', '-', '.', ',', :loop) do
		def evaluate
			case instruction
			when '>'
				tape[ ptr += 1 ] ||= 0
			when '<'
				ptr -= 1 unless ptr == 0
			when '+'
				tape = (tape[ptr] += 1) % 256
			when '-'
				tape = (tape[ptr] -= 1) % 256
			when '.'
				print tape[ptr].chr
			when ','
				tape[ptr] = (STDIN.getch.ord) % 256
			when :loop
				loop.evaluate
			end
		end
	end
	
	rule :loop, '[', :instructions, ']' do
		def evaluate;
			while tape[ptr] != 0; instructions.evaluate; end
		end
	end
	
	rule :instructions, many?(:instruction)
end

BabelBridge::Shell.new(BFParser.new).start
=end