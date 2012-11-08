# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |spec|
  spec.version = '0.3.0'
  spec.name = 'zabbixapi'
  spec.summary = 'Ruby module for work with zabbix api.'

  spec.email = 'vadv.mkn@gmail.com'
  spec.author = ["Eduard Snesarev", "Dmitry Vasiliev", "mathiasmethner@googlemail.com"]
  spec.homepage = 'https://github.com/vadv/zabbixapi/wiki'
  spec.description = 'Ruby module for work with zabbix api v1.8.'

  spec.has_rdoc = true
  spec.extra_rdoc_files  = 'README.rdoc'

  spec.rubyforge_project = "zabbixapi"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
