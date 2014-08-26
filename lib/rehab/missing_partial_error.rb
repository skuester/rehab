module Rehab
	class MissingPartialError < StandardError

		attr_reader :path


		def initialize(path)
			@path = path
		end


		def message
			"Could not find #{path}"
		end

	end
end
