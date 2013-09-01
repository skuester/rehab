require 'ostruct'
require_relative "../rehab"

describe Rehab do
	let(:scope) do
		OpenStruct.new(
			greet: 'World',
			awesome: false
			)
	end


	context "when the value is defined" do
		it "puts a variable from scope" do
			out = Rehab.new('Hello {{ greet }}').render(scope)
			expect(out).to eq 'Hello World'
		end


		it "renders multiple lines" do
			src = <<-EOF
			Hello {{ greet }}
			Hello {{ greet }}
			EOF

			out = <<-EOF
			Hello World
			Hello World
			EOF

			expect(
				Rehab.new(src).render(scope)
			).to eq out
		end
	end # when defined


	it "doesn't care about white space" do
		out = Rehab.new('Hello {{greet         }}').render(scope)
		expect(out).to eq 'Hello World'
	end


	it "evals statements with conditionals" do
		src = "You are so {{ awesome ? 'Awesome' : 'Meh' }}"
		out = Rehab.new(src).render(scope)
		expect(out).to eq "You are so Meh"
	end
end
