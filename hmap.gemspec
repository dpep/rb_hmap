$LOAD_PATH.unshift 'lib'
package_name = File.basename __FILE__, '.gemspec'
require "#{package_name}"

klass_name = Object.constants.reverse.find do |c|
  c.to_s.downcase == package_name
end
package = Object.const_get klass_name


Gem::Specification.new do |s|
  s.name        = package_name
  s.version     = package.const_get 'VERSION'
  s.authors     = ['Daniel Pepper']
  s.summary     = package.to_s
  s.description = 'Improved Hash mapping functions'
  s.homepage    = "https://github.com/dpep/rb_#{package_name}"
  s.license     = 'MIT'
  s.files       = `git ls-files * ':!:spec'`.split("\n")

  s.required_ruby_version = ">= 3"

  s.add_development_dependency 'byebug', '>= 11'
  s.add_development_dependency 'rspec', '>= 3.10'
  s.add_development_dependency 'simplecov', '>= 0.22'
end
