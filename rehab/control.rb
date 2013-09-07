module Rehab
	class Control < Filter
		def on_rehab_control(code)
			[:code, code]
		end
	end
end
