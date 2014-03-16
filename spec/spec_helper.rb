require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter '/spec/'
end

require 'rspec'
require 'jekyll_prism'

require 'jekyll'

module Jekyll
  module AssetsPlugin
    ##
    # Add helper stuffs for tests
    module RSpecHelpers
      def fixtures_path
        @fixtures_path ||= Pathname.new(__FILE__).parent.parent.join 'fixtures'
      end

      module_function :fixtures_path
    end
  end
end

RSpec.configure do |config|
  config.include Jekyll::AssetsPlugin::RSpecHelpers

  config.before(:all) do
    Jekyll.logger.log_level = Jekyll::Stevenson::WARN

    @dest = fixtures_path.join('_site')
    @site = Jekyll::Site.new(Jekyll.configuration(
      'source'      => fixtures_path.to_s,
      'destination' => @dest.to_s
    ))

    @dest.rmtree if @dest.exist?
    @site.process
  end

  config.after(:all) do
    @dest.rmtree if @dest.exist?
  end
end
