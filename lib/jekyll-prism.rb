require 'jekyll'

##
# Extend Jekyll to provide Prism helper blocks and tags
module Jekyll
  ##
  # Block object for Prism hilighting
  class CodeBlock < Liquid::Block
    def initialize(a, args, b)
      super
      options = args.split
      @lang, @linenos = options.shift 2
    end

    def render(_)
      code = h(super).strip

      linenos = @linenos == 'all' ? "1-#{code.lines.count}" : @linenos
      linestring = linenos.nil? ? '' : %Q{ data-line="#{@linenos}"}
      langstring = lang.nil? ? '' : %Q{ class="language-#{@lang}"}

      <<-OUTPUT
<pre#{linestring}><code#{langstring}>
#{code}
</code></pre>
      OUTPUT
    end
  end

  ##
  # Tag object for Prism hilighting
  class CodeTag < Liquid::Tag
    def initialize(_, args, _)
      super
      options = args.split
      @lang, @file, @linenos = options.shift 3
    end

    def render(_)
      linenos = @linenos == 'all' ? "1-#{code.lines.count}" : @linenos
      linestring = linenos.nil? ? '' : %Q{ data-line="#{@linenos}"}
      langstring = lang.nil? ? '' : %Q{ class="language-#{@lang}"}

      %Q{<pre data-src="#{@file}"#{langstring}#{linestring}></pre>}
    end
  end
end

Liquid::Template.register_tag('code', Jekyll::CodeBlock)
Liquid::Template.register_tag('code', Jekyll::CodeTag)
