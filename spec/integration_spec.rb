require 'ostruct'
require_relative "../rehab"

describe "Rehab expression" do
	let(:scope) do
		OpenStruct.new(
			item: OpenStruct.new(greet: 'World'),
			awesome: false
			)
	end

	it "puts a variable from scope" do
		out = Rehab::Template.new { 'Hello {{ item.greet }} and {{ item.greet }}' }.render(scope)
		expect(out).to eq 'Hello World and World'
	end


	it "renders multiple lines" do
		src = <<-EOF
		Hello {{ item.greet }}
		Hello {{ item.greet }}
		EOF

		out = <<-EOF
		Hello World
		Hello World
		EOF

		expect(
			Rehab::Template.new { src }.render(scope)
		).to eq out
	end


	xit "doesn't care about white space" do
		out = Rehab::Template.new('Hello {{item.greet         }}').render(scope)
		expect(out).to eq 'Hello World'
	end


	xit "is a plain ruby expression" do
		src = "You are so {{ awesome ? 'Awesome' : 'Meh' }}"
		out = Rehab::Template.new(src).render(scope)
		expect(out).to eq "You are so Meh"
	end
end



describe "Rehab control flow statement" do
	let(:scope) do
		OpenStruct.new(
			item: OpenStruct.new(greet: 'World'),
			true_condition: true,
			false_condition: false
			)
	end

	xit "renders if else" do
		src = <<-EOF
		first line
		# if true_condition
			A true
		# else
			A false
		# end
		# if false_condition
			B true
		# else
			B false
		# end
		EOF

		out = <<-EOF
		first line
		A true
		B false
		EOF

		expect( Rehab::Template.new { src }.render(scope) ).to eq out
	end
end
