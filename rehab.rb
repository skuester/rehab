class Rehab
	attr_reader :source

	def initialize(source)
		@source = source
	end

	def render(context)
		search = /\{\{([^\}]+)\}\}/
		source.gsub search do |match|
			context.instance_eval match[search, 1]
		end
	end
end
