#Ruby Zabbix Api Module

Simple and lightweight ruby module for work with zabbix api 

[![Build Status](https://travis-ci.org/vadv/zabbixapi.png)](https://travis-ci.org/vadv/zabbixapi)

## Installation
```
gem install zabbixapi
```

## Get Start

### Connect
```ruby
zbx = ZabbixApi.connect(
  :url => 'http://localhost/zabbix/api_jsonrpc.php',
  :user => 'Admin',
  :password => 'zabbix'
)
```
### Create Hostgroup
```ruby
zbx.hostgroups.create(:name => "hostgroup")
```

### Create Template
```ruby
zbx.templates.create(
  :host => "template",
  :groups => [:groupid => zbx.hostgroups.get_id(:name => "hostgroup")]
)
```

### Create Application
```ruby
zbx.applications.create(
  :name => application,
  :hostid => zbx.templates.get_id(:host => "template")
)
```

### Create Item
```ruby
zbx.items.create(
  :description => "item",
  :key_ => "proc.num[aaa]",
  :hostid => zbx.templates.get_id(:host => "template"),
  :applications => [zbx.applications.get_id(:name => "application")]
)
```

### Create host
```ruby
zbx.hosts.add(
  :host => "hostname",
  :groups => [ :groupid => zbx.hostgroups.get_id(:name => "hostgroup") ]
)
```

## Dependencies

* net/http
* net/https
* json

## Zabbix documentation

* Zabbix Project Homepage -> http://zabbix.com/
* Zabbix Api docs -> http://www.zabbix.com/documentation/1.8/api