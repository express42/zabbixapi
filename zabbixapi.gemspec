# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'zabbixapi/version'

Gem::Specification.new do |s|
  s.name        = "zabbixapi"
  s.version     = ZabbixApi::VERSION
  s.authors     = ["Vasiliev D.V.", "Ivan Evtuhovich"]
  s.email       = %w(vadv.mkn@gmail.com evtuhovich@gmail.com)
  s.homepage    = "https://github.com/express42/zabbixapi"
  s.summary     = %q{Realization for Zabbix API.}
  s.description = %q{Allows you to work with zabbix api from ruby.}
  s.licenses    = %w(MIT)

  s.add_dependency 'json'

  s.rubyforge_project = "zabbixapi"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)
end
