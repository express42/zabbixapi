#!/usr/bin/env ruby

require 'rubygems'
require 'getopt/std'
require 'yaml'
require 'zabbixapi'

opt = Getopt::Std.getopts("g:E:")

group_name = opt["g"]
zabbix_env = opt["E"]

maintenance_name = "Test Maintenance"

# read config
config = YAML::load(open('./config.yml'))

api_url = config[zabbix_env]["api_url"]
api_login = config[zabbix_env]["api_login"]
api_password = config[zabbix_env]["api_password"]

# Esablish new connection
zbx = Zabbix::ZabbixApi.new(api_url, api_login, api_password)
zbx.debug = true
#Simply uses the api_login and api_password for basic auth
zbx.basic_auth = true

p " * Creating hostgroup #{group_name}."
g_id = zbx.add_or_get_group(group_name)
puts g_id
