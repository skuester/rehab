class Rehab::Parser < Temple::Parser
	attr_reader :source, :out, :line


	define_options :file_provider


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


	INCLUDE = /\A\s*#\s*(include)\s*(\S*)\s?(.*)?/
	CONTROL = /\A\s*#\s*(.*)$/
	EXPRESSION = /\{\{/m
	def parse_line
		case @line
		when INCLUDE
			out << parse_include($2, $3)
		when CONTROL
			out << [:rehab, :control, $1]
		when EXPRESSION
			out << [:rehab, :interpolate, @line]
		else
			out << [:static, @line]
		end
	end


	def parse_include(path, control = '')
		if control.empty?
			parse_file_content(path)
		else
			parse_include_with_control(path, control)
		end
	end


	def parse_file_content(path)
		included_content = options[:file_provider].call(path)
		self.class.new.call(included_content)
	end


	def parse_include_with_control(path, control)
		section = [:multi]
		section << [:code, control]
		section << parse_file_content(path)
		section << [:code, 'end']
	end
end
