# encoding: UTF-8

require File.expand_path('../lib/associo/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'associo'
  s.summary     = %(MongoMapper and GridFS joined in file upload love.)
  s.description = %(Implements an easy to use GridFS API for MongoMapper.)
  s.email       = 'syntruth@gmail.com'
  s.homepage    = ''
  s.authors     = ['John Nunemaker', 'Randy Carnahan']
  s.version     = Associo::VERSION

  s.add_dependency 'wand', '~> 0.4'
  s.add_dependency 'mime-types'
  s.add_dependency 'mongo_mapper', '~> 0.9'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f|
    File.basename(f)
  }

  s.require_paths = ['lib']
end
