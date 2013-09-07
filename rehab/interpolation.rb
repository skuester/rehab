module Rehab
	# inline like: {{ foo }}
	class Interpolation < Filter

		def on_rehab_interpolate(string)
			block = [:multi]
			begin
				case string
				when /\{\{/m
					block << [:static, $`]
					exp, string = parse_expression $'
					block << [:dynamic, exp]
				else
					block << [:static, string]
					string = ""
				end
			end until string.empty?
			block
		end

		private


		def parse_expression(string)
			/\}\}/m.match(string)
			[$`, $']
		end
	end
end
