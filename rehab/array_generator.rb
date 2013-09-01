class Rehab::ArrayGenerator
	attr_accessor :buffer

	def initialize
		@buffer = []
	end


	def <<(line)
		buffer << line
	end


	def flush
		buffer.join
	end
end
