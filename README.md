jekyll_prism
=========

[![Gem Version](https://img.shields.io/gem/v/jekyll_prism.svg)](https://rubygems.org/gems/jekyll_prism)
[![Dependency Status](https://img.shields.io/gemnasium/akerl/jekyll_prism.svg)](https://gemnasium.com/akerl/jekyll_prism)
[![Code Climate](https://img.shields.io/codeclimate/github/akerl/jekyll_prism.svg)](https://codeclimate.com/github/akerl/jekyll_prism)
[![Coverage Status](https://img.shields.io/coveralls/akerl/jekyll_prism.svg)](https://coveralls.io/r/akerl/jekyll_prism)
[![Build Status](https://img.shields.io/travis/akerl/jekyll_prism.svg)](https://travis-ci.org/akerl/jekyll_prism)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Jekyll plugin to add support for [prism.js](http://prismjs.com/).

## Usage

This adds `code` blocks and `ext_code` tags for syntax highlighting.

### code block

The `code` block creates the necessary HTML for prism to do its thing:

```
{% code %}
#!/bin/bash

echo "I'm so cool"
{% endcode %}
```

You can also pass a language option to set the language used for highlighting:

```
{% code ruby %}
require 'cool_module'

puts "I'm so cool, for reals"
{% endcode %}
```

If you're using prism with the line numbers plugin, you can provide line numbers to highlight (use 'all' to highlight all lines):

```
{% code ruby 1,3 %}
require 'cool_module'

puts "I'm so cool, for reals"
{% endcode %}
```

### ext_code tag

This tag uses the file highlight plugin for prism, and creates an HTML object to include external code:

```
{% ext_code /path/to/cool/code.rb %}
```

You can provide language and line number parameters for this as well, just like the code block:

```
{% ext_code /path/to/cooler/code.rb ruby 1,10-51,77,90 %}
```

## Installation

1. Add 'jekyll_prism' to the `gems` array in your \_config.yml
2. Add the prism.js and prism.css files to your site, as described [on prism's site](http://prismjs.com/download.html)
  * Note: the ext_code tag uses the File Highlight plugin. If you don't include that, the tags won't work

## License

jekyll_prism is released under the MIT License. See the bundled LICENSE file for details.

