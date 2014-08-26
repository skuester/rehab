require 'ostruct'
require_relative "../lib/rehab"

describe Rehab do
	def template(src, opts = {})
		Rehab::Template.new(opts) { src }.render(scope)
	end

	describe "interpolation" do
		let(:scope) do
			OpenStruct.new(
				item: OpenStruct.new(greet: 'World'),
				awesome: false
				)
		end


		it "puts a variable from scope" do
			src = 'Hello {{ item.greet }} and {{ item.greet }}'
			out = 'Hello World and World'
			expect(template src).to eq out
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
			expect(template src).to eq out
		end


		it "doesn't care about white space" do
			src = 'Hello {{item.greet         }}'
			out = 'Hello World'
			expect(template src).to eq out
		end


		it "is a plain ruby expression" do
			src = "You are so {{ awesome ? 'Awesome' : 'Meh' }}"
			out = "You are so Meh"
			expect(template src).to eq out
		end
	end




	describe "control flow" do
		let(:scope) do
			OpenStruct.new(
				item: OpenStruct.new(greet: 'World'),
				true_condition: true,
				false_condition: false
			)
		end


		it "renders a plain ruby block without 'do'" do
			src = <<-EOF
			<ul>
			# 3.times
				<li>Hello</li>
			#end
			</ul>
			EOF

			out = <<-EOF
			<ul>
				<li>Hello</li>
				<li>Hello</li>
				<li>Hello</li>
			</ul>
			EOF
			expect(template src).to eq out
		end


		it "renders a plain ruby block WITH 'do' and block" do
			src = <<-EOF
			<ul>
			# 3.times do |n|
				<li>Hello {{ n }}</li>
			# end
			</ul>
			EOF

			out = <<-EOF
			<ul>
				<li>Hello 0</li>
				<li>Hello 1</li>
				<li>Hello 2</li>
			</ul>
			EOF
			expect(template src).to eq out
		end


		it "renders if else" do
			src = <<-EOF
			first line
			# if true_condition
				A main
			# else
				A else
			# end
			# if false_condition
				B main
			# else
				B else
			# end
			EOF

			out = <<-EOF
			first line
				A main
				B else
			EOF
			expect(template src).to eq out
		end

	end




	describe "special controls" do
		let(:scope) do
			OpenStruct.new({
				people: [
					OpenStruct.new(name: 'Bill'),
					OpenStruct.new(name: 'Fred')
				]
			})
		end


		it "renders for ... in" do
			src = <<-EOF
			# for person in people
				<p>{{ person.name }}</p>
			# end
			EOF

			out = <<-EOF
				<p>Bill</p>
				<p>Fred</p>
			EOF
			expect(template src).to eq out
		end
	end

	describe "include" do
		let(:scope) do
			OpenStruct.new(
				message: 'Hello World!',
				people: [
					OpenStruct.new(name: 'Bill'),
					OpenStruct.new(name: 'Fred')
				]
			)
		end

		# an file_provider is anything that responds to "call"
		# it should return the contents of the file
		it "renders partials using a file provider" do
			src = <<-EOF
			# include my_partial.html
			<p>content</p>
			EOF

			file = double("File Provider", call: <<-EOF
			<p>{{ message }}</p>
			EOF
			)

			out = <<-EOF
			<p>Hello World!</p>
			<p>content</p>
			EOF
			expect( file ).to receive(:call).with('my_partial.html')
			expect(template(src, {file_provider: file})).to eq out
		end

		it "renders partials using a default file provider" do
			File.open('tmp/my_partial.html', 'w') { |f| f.write "<p>{{ message }}</p>" }
			src = <<-EOF
			# include tmp/my_partial.html
			<p>content</p>
			EOF

			out = <<-EOF
<p>Hello World!</p>
			<p>content</p>
			EOF
			expect(template(src)).to eq out
			File.delete('tmp/my_partial.html')
		end


		it "provides a meaningful error when template is missing" do
			src = <<-EOF
			# include missing.html
			<p>content</p>
			EOF

			expect{ template(src) }.to raise_error Rehab::MissingPartialError, "Could not find missing.html"
		end

		it "works with for .. in comprehension" do
			src = <<-EOF
			# include my_partial.html for person in people
			EOF

			file = ->(ignore) {
			<<-EOF
			<p>{{ person.name }}</p>
			EOF
			}

			out = <<-EOF
			<p>Bill</p>
			<p>Fred</p>
			EOF
			expect(template(src, {file_provider: file})).to eq out
		end
	end
end
