require 'temple'
require 'tilt'


module Rehab
	VERSION = '0.1.2'
end

require 'rehab/file_provider'
require 'rehab/filter'
require 'rehab/interpolation'
require 'rehab/control'
require 'rehab/do_filter'
require 'rehab/parser'
require 'rehab/missing_partial_error'


require 'rehab/engine'
require 'rehab/template'
