Rehab
=====

Simple, Portable Template Language.

	Rehab::Template.new(options) { "template_source" }.render(scope)

See the tests and `sample.html` for documentation.


Syntax Overview
---------------
The goal is to have very little syntax, other than plain ruby and a couple conveniences for templating.
It may be harnessing the full power of ruby, but remember: just because you *can* doesn't mean you *should*.

Interpolation:

	<p>{{ greeting }} World!<p>

Control Flow:

	# if greeting.empty?
		<p>I have nothing to say<p>
	# end

Block:

	# 3.times.do |n|
		<p>{{ n }}. Why didn't I use an ordered list?</p>
	# end

Optional "Short" Block (without the 'Do'):

	# 3.times
		<blink>Click Me!<blink>
	# end

Include partial:

	# include my_partial.html

Include partial for each item in a collection:

	# include awesome-post.html for post in posts


------


Future Plans
============
* It would be awesome to have an implementation not tied to Ruby, but... Ruby is pretty.
* Implement simple filter syntax, see todo.html
