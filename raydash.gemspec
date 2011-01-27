# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "raydash/version"

Gem::Specification.new do |s|
  s.name        = "raydash"
  s.version     = Raydash::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Gershon Bialer"]
  s.email       = ["gershon@raydash.com"]
  s.homepage    = ""
  s.summary     = %q{Embed video chat or video streaming via Raydash}
  s.description = %q{Live video chat or video streams can be hosted on Raydash, and accessed via the API contained within this gem}

  s.rubyforge_project = "raydash"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
