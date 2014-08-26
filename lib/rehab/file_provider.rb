module Rehab
	FileProvider = ->(path) {
		begin
			File.read(path) + "\n"
		rescue Errno::ENOENT
			raise MissingPartialError.new(path)
		end
	}
end
