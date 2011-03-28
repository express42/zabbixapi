require 'rubygems'
require 'rake'
require 'echoe'

Gem::Specification.new do |spec|

  spec.version = '0.1.4'
  spec.name = 'zabbixapi'
  spec.summary = 'Ruby module for work with zabbix api.'

  spec.email = 'verm666@gmail.com'
  spec.author = 'Eduard Snesarev'
  spec.homepage = 'http://github.com/verm666/RubyZabbixApi'
  spec.description = 'Ruby module for work with zabbix api. '

  spec.has_rdoc = true
  spec.extra_rdoc_files  = 'README.rdoc'


  spec.files = FileList["lib/*.rb", "bin/*", "spec/*", 'zabbixapi.gemspec', 'README.rdoc'].to_a
end
