require 'spec_helper'

describe Jekyll::CodeBlock do
  it 'renders code blocks' do
    code = 'foobar'
    block = Jekyll::CodeBlock.new('code', 'ruby', []).render(code)
    result = '<pre><code class="language-ruby">
foobar
</code></pre>'
    expect(block).to eql result
  end
end

describe Jekyll::CodeTag do
end
