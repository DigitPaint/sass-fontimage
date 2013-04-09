# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
Gem::Specification.new do |s|
  s.name = "sass-fontimage"
  s.version = "0.1.1"
  s.authors = ["Digitpaint"]
  s.email = %q{info@digitpaint.nl}
  s.homepage = %q{http://github.com/digitpaint/sass-fontimage}  
  s.description = %q{A small extension for SASS that generates images from icon fonts}
  s.summary = %q{A small extension for SASS that generates images from icon fonts}

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.require_paths = ["lib"]  
  
  s.extra_rdoc_files = [
    "README.md"
  ]
  
  s.files         = `git ls-files --exclude=.gitignore --exclude-standard`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  
  s.add_dependency "rmagick"
  s.add_dependency "sass"
end

