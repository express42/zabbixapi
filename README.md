#Ruby Zabbix Api Module

Simple and lightweight ruby module for work with zabbix api 

[![Build Status](https://travis-ci.org/vadv/zabbixapi.png)](https://travis-ci.org/vadv/zabbixapi)

#####Now worked with zabbix 
* 1.8.2 (api version 1.2)
* 1.8.9 (api version 1.3)

## Installation
```
gem install zabbixapi
```

## Get Start

### Connect
```ruby
require "zabbixapi"

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
# or use (lib merge json):
zbx.items.create_or_update(
  :description => "item",
  :key_ => "proc.num[aaa]",
  :type => 6,
  :hostid => zbx.templates.get_id(:host => "template"),
  :applications => [zbx.applications.get_id(:name => "application")]
)
```

### Update Item
```ruby
zbx.items.update(
  :itemid => zbx.items.get_id(:description => "item"),
  :status => 0
)
#You can check item:
puts zbx.items.get_full_data(:description => "item")
```

### Create host
```ruby
zbx.hosts.add(
  :host => "hostname",
  :usedns => 1,
  :groups => [ :groupid => zbx.hostgroups.get_id(:name => "hostgroup") ]
)
#or use:
zbx.hosts.create_or_update(
  :host => host,
  :usedns => 0,
  :ip => "10.20.48.89",
  :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
)
```

### Update host
```ruby
zbx.hosts.update(
  :hostid => zbx.hosts.get_id(:host => "hostname"),
  :status => 0
)
#You can check host:
puts zbx.hosts.get_full_data(:host => "hostname")
```

### Delete host
```ruby
zbx.hosts.delete zbx.hosts.get_id(:host => "hostname")
```

### Create graph
```ruby
gitems = {
  :itemid => zbx.items.get_id(:description => "item"), 
  :calc_fnc => "2",
  :type => "0",
  :periods_cnt => "5"
}

zbx.graphs.create(
  :gitems => [gitems],
  :show_triggers => "0",
  :name => "graph",
  :width => "900",
  :height => "200"
)
```

### Update graph
```ruby
zbx.graphs.update(
  :graphid => zbx.graphs.get_id( :name => "graph"), 
  :ymax_type => 1
)
#Also you can use:
gitems = {
  :itemid => zbx.items.get_id(:description => item), 
  :calc_fnc => "3",
  :type => "0",
  :periods_cnt => "5"
}
zbx.graphs.create_or_update(
  :gitems => [gitems],
  :show_triggers => "1",
  :name => graph,
  :width => "900",
  :height => "200"
)
```
### Get ids by host ###
```ruby
zbx.graphs.get_ids_by_host(:host => "hostname")
```

### Delete graph
```ruby
zbx.graphs.delete(zbx.graphs.get_id(:name => "graph"))
```

### Get all templates linked with host
```ruby
zbx.templates.get_ids_by_host( :hostids => [zbx.hosts.get_id(:host => "hostname")] )
#returned hash:
#{
#  "Templatename" => "10",
#  "Templatename" => "1021"
#}
``` 

### Mass (Un)Link host with templates
```ruby
zbx.templates.mass_add(
  :hosts_id => [zbx.hosts.get_id(:host => "hostname")],
  :templates_id => [111, 214]
)
zbx.templates.mass_remove(
  :hosts_id => [zbx.hosts.get_id(:host => "hostname")],
  :templates_id => [111, 214]
)
```

### Create trigger
```ruby
zbx.triggers.create(
  :description => "trigger",
  :expression => "{template:proc.num[aaa].last(0)}<1",
  :comments => "Bla-bla is faulty (disaster)",
  :priority => 5,
  :status     => 0,
  :templateid => 0,
  :type => 0
 )
````

### Create user
```ruby
zbx.users.create(
  :alias => "Test user",
  :name => "username",
  :surname => "usersername",
  :passwd => "password"
)
```

### Update user
```ruby
zbx.users.update(:userid => zbx.users.get_id(:name => "user"), :name => "user2")
```

### Delete graph
```ruby
zbx.graphs.delete(zbx.graphs.get_id(:name => "graph"))
```

### Create screen for host  ###
```ruby
zbx.screens.get_or_create_for_host(
  :host => "hostname",
  :graphids => zbx.graphs.get_ids_by_host(:host => "hostname")
)
```

### Custom queries
```ruby
zbx.query(
  :method => "apiinfo.version", 
  :params => {}
)
```

## Dependencies

* net/http
* net/https
* json

## Contributing

* Fork the project.
* Make your feature addition or bug fix, write tests.
* Commit, do not mess with rakefile, version.
* Make a pull request.

## Zabbix documentation

* [Zabbix Project Homepage](http://zabbix.com/)
* [Zabbix Api docs](http://www.zabbix.com/documentation/1.8/api) 
