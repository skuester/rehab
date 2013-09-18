# namespace
module Rehab
	VERSION = '0.1.0'


end

require 'temple'
require 'tilt'

require_relative 'rehab/filter'
require_relative 'rehab/interpolation'
require_relative 'rehab/control'
require_relative 'rehab/do_filter'
require_relative 'rehab/parser'

require_relative 'rehab/engine'

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
