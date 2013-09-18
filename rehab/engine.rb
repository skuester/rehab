module Rehab
	class Engine < Temple::Engine

		use Rehab::Parser, :file_resolver

		use Rehab::Interpolation
		use Rehab::DoFilter
		use Rehab::Control

		filter :MultiFlattener
		filter :StaticMerger
		filter :DynamicInliner

		generator :ArrayBuffer
	end
end
