# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "things_fetcher/version"

Gem::Specification.new do |s|
  s.name        = "things-fetcher"
  s.version     = ThingsFetcher::VERSION
  s.authors     = ["Andrey Subbotin"]
  s.email       = ["andrey@subbotin.me"]
  s.homepage    = "http://github.com/eploko/things-fetcher"
  s.summary     = "Imports TODOs from IMAP to Things.app"
  s.description = "A simple daemon to periodically check an IMAP folder and create a new TODO in the Things app for each new message."

  s.rubyforge_project = "things-fetcher"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency "mail"
  s.add_runtime_dependency "rb-appscript"
end
