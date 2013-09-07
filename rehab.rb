# namespace
module Rehab
	VERSION = '0.1.0'


end

require 'temple'
require 'tilt'
# require_relative 'rehab/array_generator'
require_relative 'rehab/filter'
require_relative 'rehab/interpolation'
require_relative 'rehab/parser'
require_relative 'rehab/engine'

module Rehab
	Template = Temple::Templates::Tilt(Rehab::Engine, :register_as => 'html')
end
