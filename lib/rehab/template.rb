# usage: Rehab::Template.new(options) { source }.render(scope)
module Rehab
	class Template
		attr_reader :tilt, :source

		def initialize(opts = {})
			@source = yield
			@tilt = Temple::Templates::Tilt(Rehab::Engine, opts).new { source }
		end

		def render(scope)
			tilt.render(scope)
		end
	end
end
