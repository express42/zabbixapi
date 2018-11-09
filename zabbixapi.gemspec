lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'zabbixapi/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'http', '~> 2.0'
  spec.add_dependency 'json', '~> 2.0'
  spec.add_development_dependency 'bundler', '~> 1.0'

  spec.name        = 'ets_zabbixapi'
  spec.version     = ZabbixApi::VERSION
  spec.authors     = ['Scott Mackensen']
  spec.email       = ['scott.mackensen@cerner.com']

  spec.summary     = 'Internal Fork of the Zabbixapi Gem located here:https://github.com/express42/zabbixapi'
  spec.description = 'Simple and lightweight ruby module for working with the Zabbix API'
  spec.homepage    = 'https://github.cerner.com/ETS/ets_zabbixapi'
  spec.licenses    = 'MIT'

  spec.rubyforge_project = 'zabbixapi'

  spec.files         = ['.yardopts', 'CHANGELOG.md', 'LICENSE.md', 'README.md', 'zabbixapi.gemspec'] + Dir['lib/**/*.rb']
  spec.require_paths = 'lib'
  spec.required_ruby_version = '>= 2.2.0'
end
