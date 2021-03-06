# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name = 'coco'
  s.version = File.read('VERSION').strip
  s.authors = ['Xavier Nayrac']
  s.email = 'xavier.nayrac@gmail.com'
  s.summary = 'Code coverage tool for ruby 1.9.'
  s.homepage = 'http://lkdjiin.github.com/coco/'
  s.description = %q{"Another code coverage tool for ruby 1.9
(from the famous post of Aaron Patterson).
* Simply "require 'coco'" from rspec or unit/test
* Display filenames covered less than 90% on console
* Build simple html report only for files covered less than 90%
* Report sources that have no tests
* UTF-8 compliant
* Configurable with a simple yaml file
* Colorized console output (*nix only)}
	
	readmes = FileList.new('*') do |list|
		list.exclude(/(^|[^.a-z])[a-z]+/)
		list.exclude('TODO')
	end.to_a
  s.files = FileList['lib/**/*.rb', 'template/**/*', '[A-Z]*'].to_a + readmes
	s.license = 'GPL-3'
	s.required_ruby_version = '>= 1.9.2'
end
