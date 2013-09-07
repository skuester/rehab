module Rehab
	class Engine < Temple::Engine
		use ::Rehab::Parser
		use ::Rehab::Interpolation
		use ::Rehab::DoFilter
		use ::Rehab::Control

		# filter :MultiFlattener
		# filter :StaticMerger
		# filter :DynamicInliner
		filter :Escapable
		filter :ControlFlow
		generator :ArrayBuffer, :newline
	end
end
