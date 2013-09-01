# A stream accepts one line at a time
 module Rehab
 	module Streams
	 	class Memory
			attr_accessor :content

			def initialize
				@content = []
			end


			def <<(line)
				content << line
			end


			def close
				content.join
			end
		end # Memory
	end
end
