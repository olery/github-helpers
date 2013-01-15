# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','github-helpers','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'github-helpers'
  s.version = GithubHelpers::VERSION
  s.author = 'Wilco van Duinkerken'
  s.email = 'wilcovanduinkerken@sparkboxx.com'
  s.homepage = 'http://www.olery.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Series of tools to help manage github collaborators when you have a lot of repositories.'
# Add your other files here if you make them
  s.files = %w(
bin/github-helpers
lib/github-helpers/version.rb
lib/github-helpers.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','github-helpers.rdoc']
  s.rdoc_options << '--title' << 'github-helpers' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'github-helpers'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.5.3')
  s.add_dependency('github_api')
  s.add_dependency('highline')
end
