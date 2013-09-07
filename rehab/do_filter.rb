module Rehab
	class DoFilter < Filter
		BLOCK_REGEX = /(\A(if|unless|else|elsif|when|begin|rescue|ensure|case|end)\b)|do\s*(\|[^\|]*\|\s*)?\Z/

		def on_rehab_control(code)
			code = code + ' do' unless code =~ BLOCK_REGEX
			[:rehab, :control, code]
		end
	end
end
