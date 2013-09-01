
module Rehab
	def self.compile(source)
		source.lines.each do |line|
			matcher = /#\s(.+)\n/
			command = source[matcher, 1]
			unless command.nil?
				command += " do"
			end
		end
	end

	class Digest
		attr_reader :source, :out
		attr_accessor :scope

		def initialize(source)
			@source = source
			@scope = {}
		end

		def run
			compile_variables
		end

		def compile_variables
			copy = source
			source.scan(/({{\s(.+)\s}})/) do |str, name|
				copy.sub!(/#{str}/, scope[name])
			end
			copy
		end
	end


	# module Matche
	r
	# 	class Default
	# 		attr_accessor :line

	# 		def initialize(line)
	# 			@line = line
	# 		end

	# 		def applies?
	# 			true
	# 		end

	# 		def apply(scope)
	# 			scope << line
	# 		end
	# 	end
	# end
end
