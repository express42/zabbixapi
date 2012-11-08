# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |spec|

  spec.version = '0.2.0'
  spec.name = 'zabbixapi'
  spec.summary = 'Ruby module for work with zabbix api.'

  spec.email = 'vadv.mkn@gmail.com'
  spec.author = 'Eduard Snesarev and Dmitry Vasiliev, mathiasmethner@googlemail.com'
  spec.homepage = 'https://github.com/vadv/zabbixapi/wiki'
  spec.description = 'Ruby module for work with zabbix api v1.8.'

  spec.has_rdoc = true
  spec.extra_rdoc_files  = 'README.rdoc'

  spec.files = FileList["lib/*.rb", "lib/zabbixapi/*.rb", "bin/*", "spec/*", 'zabbixapi.gemspec', 'README.rdoc', "examples/*"].to_a
end
