class Rehab::Parser
	attr_reader :source, :out, :line


	def initialize(opts)
		super()
	end


	def call(source)
		@lines = source.lines
		@out = [:multi]
		parse_line while next_line
		out
	end


protected


	def next_line
		@line = @lines.shift
	end


	CONTROL = /^\s*#/m
	EXPRESSION = /\{\{/m
	def parse_line
		# binding.pry
		case @line
		when CONTROL
			# out << [:rehab, :control, @line]
		when EXPRESSION
			out << [:rehab, :interpolate, @line]
		else
			out << [:static, @line]
		end
	end
end