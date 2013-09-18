class Rehab::Parser < Temple::Parser
	attr_reader :source, :out, :line


	define_options :file_resolver


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


	INCLUDE = /\A\s*#\s*(include)\s*(\S*)/
	CONTROL = /\A\s*#\s*(.*)$/
	EXPRESSION = /\{\{/m
	def parse_line
		case @line
		when INCLUDE
			out << parse_include($2)
		when CONTROL
			out << [:rehab, :control, $1]
		when EXPRESSION
			out << [:rehab, :interpolate, @line]
		else
			out << [:static, @line]
		end
	end

	def parse_include(path)
		included_content = options[:file_resolver].call(path)
		self.class.new.call(included_content)
	end
end
