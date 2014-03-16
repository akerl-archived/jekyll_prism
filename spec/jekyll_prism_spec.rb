require 'spec_helper'

##
# Helper to save keystrokes
def test_template(input, output)
  expect(Liquid::Template.parse(input).render).to eql output
end

describe Jekyll::CodeBlock do
  it 'renders code blocks' do
    code = '{% code %}foobar{% endcode %}'
    result = "<pre><code>\nfoobar\n</code></pre>\n"
    test_template code, result
  end

  it 'accepts a language parameter' do
    code = '{% code ruby %}foobar{% endcode %}'
    result = "<pre><code class=\"language-ruby\">\nfoobar\n</code></pre>\n"
    test_template code, result
  end

  describe 'accepts a linenos parameter' do
    it 'as line numbers' do
      code = '{% code ruby 1,3-5,10 %}foobar{% endcode %}'
      result = "<pre data-line=\"1,3-5,10\"><code class=\"language-ruby\">
foobar
</code></pre>\n"
      test_template code, result
    end
    it 'as an "all" parameter' do
      code = "{% code ruby all %}foo\nbar\nbaz{% endcode %}"
      result = "<pre data-line=\"1-3\"><code class=\"language-ruby\">
foo
bar
baz
</code></pre>\n"
      test_template code, result
    end
  end
end

describe Jekyll::CodeTag do
  it 'renders external code objects' do
    code = '{% ext_code sekrit.rb %}'
    result = '<pre data-src="sekrit.rb"></pre>'
    test_template code, result
  end

  it 'accepts a language parameter' do
    code = '{% ext_code sekrit.rb ruby %}'
    result = '<pre data-src="sekrit.rb" class="language-ruby"></pre>'
    test_template code, result
  end

  describe 'accepts a linenos parameter' do
    it 'as line numbers' do
      code = '{% ext_code sekrit.rb ruby 1,3-5,10 %}'
      result = '<pre data-src="sekrit.rb" ' \
        'class="language-ruby" data-line="1,3-5,10"></pre>'
      test_template code, result
    end
  end
end
