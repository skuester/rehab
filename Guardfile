# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cli: "--color", all_on_start: true, bundler: false do
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^rehab/(.+)\.rb$})         { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{(.+)\.rb$})         { |m| "spec/integration_spec.rb" }
end

