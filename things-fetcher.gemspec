# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "things_fetcher/version"

Gem::Specification.new do |s|
  s.name        = "things-fetcher"
  s.version     = ThingsFetcher::VERSION
  s.authors     = ["Andrey Subbotin"]
  s.email       = ["andrey@subbotin.me"]
  s.homepage    = "http://github.com/eploko/things-fetcher"
  s.summary     = "Imports to-dos from IMAP to Things.app"
  s.description = "A simple daemon to periodically check an IMAP folder and create a new to-dos in the Things app for each new message."
  
  s.rubyforge_project = "things-fetcher"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  
  s.executables = ["things-fetcher"]
  s.default_executable = ["things-fetcher"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  
  s.add_development_dependency "rake"
  
  s.add_runtime_dependency "mail"
  s.add_runtime_dependency "rb-appscript"
end
