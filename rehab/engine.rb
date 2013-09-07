module Rehab
	class Engine < Temple::Engine
		use ::Rehab::Parser
		use ::Rehab::Interpolation

		filter :MultiFlattener
		filter :StaticMerger
		filter :DynamicInliner
		generator :ArrayBuffer, :newline
	end
end
