Gem::Specification.new do |s|
  s.name        = 'jekyll_prism'
  s.version     = '0.0.4'
  s.date        = Time.now.strftime("%Y-%m-%d")

  s.summary     = ''
  s.description = ""
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/jekyll_prism'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split

  s.add_dependency 'liquid', '~> 3.0.0'

  s.add_development_dependency 'rubocop', '~> 0.50.0'
  s.add_development_dependency 'goodcop', '~> 0.0.1'
  s.add_development_dependency 'rake', '~> 12.1.0'
  s.add_development_dependency 'coveralls', '~> 0.8.0'
  s.add_development_dependency 'rspec', '~> 3.6.0'
  s.add_development_dependency 'fuubar', '~> 2.2.0'
end
