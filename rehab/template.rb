class Rehab::Template
	attr_reader :source, :scope, :stream
	attr_accessor :stream_stack

	def initialize(source)
		@source = source
		@stream_stack = []
		# open the root stream
		open_stream do
			::Rehab::Streams::Memory.new
		end
	end


	def render(context)
		@scope = context
		source.lines do |line|
			render_line line
		end
		stream.close
	end


private


	def render_line(line)
		stream << render_inline_expressions(line)
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


	def open_stream
		stream_stack << yield
		@stream = stream_stack.last
	end


	def close_stream
		complete = stream_stack.shift
		complete.close
	end
end
