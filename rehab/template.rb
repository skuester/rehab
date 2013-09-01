class Rehab::Template
	attr_reader :source, :scope
	attr_accessor :buffers, :buffer


	def initialize(source)
		@source = source
		@buffers = []
		@generator = ::Rehab::ArrayGenerator.new
		@buffers << @generator
		@buffer = @buffers.last
	end


	def render(context)
		@scope = context
		source.lines.each do |line|
			render_line line
		end
		@buffer.flush
	end


private


	def render_line(line)
		buffer << render_inline_expressions(line)
	end


	def render_control(line)
		search = /#\s?if (.+)/
	end


	def render_inline_expressions(line)
		search = /\{\{([^\}]+)\}\}/
		line.gsub search do |match|
			eval_expression match[search, 1]
		end
	end


	def eval_expression(expression)
		scope.instance_eval expression
	end


	def open_buffer
		buffers << Rehab::Buffer.new
		@buffer = buffers.last
	end

end
