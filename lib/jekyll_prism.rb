require 'liquid'

##
# Helpers for defining code HTML
module PrismHelpers
  def parse_args(args)
    args.each_with_object({}) do |arg, hash|
      value, key = arg.split('=').reverse
      key ||= 'lang'
      hash[key.to_sym] = value
    end
  end

  def pre_attrs(opts)
    s = ' class="'
    s = add_line_numbers(s, opts)
    s = add_lang(s, opts) if opts.include? :source
    s << '"'
    s = add_line_start(s, opts) unless [nil, 1].include? opts[:numbers]
    s = add_source(s, opts) if opts.include? :source
    s = add_highlights(s, opts) if opts.include? :highlights
    s
  end

  def code_attrs(opts)
    s = ' class="'
    s = add_lang(s, opts) unless opts.include? :source
    s << '"'
  end

  def add_line_numbers(s, opts)
    s << 'line-numbers ' if opts.include? :numbers
    s
  end

  def add_lang(s, opts)
    s << "language-#{opts[:lang]}" if opts.include? :lang
    s
  end

  def add_line_start(s, opts)
    s << %( data-start="#{opts[:numbers]}")
  end

  def add_highlights(s, opts)
    lines = if opts[:highlights] == 'all'
              "1-#{opts[:linecount]}"
            else
              opts[:highlights]
            end
    s << %( data-line="#{lines}")
  end

  def add_source(s, opts)
    s << %( data-src="#{opts[:source]}")
  end
end

##
# Extend Jekyll to provide Prism helper blocks and tags
module Jekyll
  ##
  # Block object for Prism hilighting
  class CodeBlock < Liquid::Block
    include Liquid::StandardFilters
    include PrismHelpers

    def initialize(a, args, b)
      super
      @options = parse_args args.split
    end

    def render(_)
      code = h(super).strip
      @options[:linecount] = code.lines.count

      <<-OUTPUT
<pre#{pre_attrs @options}><code#{code_attrs @options}>
#{code}
</code></pre>
      OUTPUT
    end
  end

  ##
  # Tag object for Prism hilighting
  class CodeTag < Liquid::Tag
    include PrismHelpers

    def initialize(_, args, _)
      super
      args = args.split
      args[0] = "source=#{args[0]}"
      @options = parse_args args
    end

    def render(_)
      "<pre#{pre_attrs @options}></pre>"
    end
  end
end

Liquid::Template.register_tag('code', Jekyll::CodeBlock)
Liquid::Template.register_tag('ext_code', Jekyll::CodeTag)
