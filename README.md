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

### Update Item
```ruby
zbx.items.update(
  :itemid => zbx.items.get_id(:description => "item"),
  :status => 0
)
```

### Create host
```ruby
zbx.hosts.add(
  :host => "hostname",
  :groups => [ :groupid => zbx.hostgroups.get_id(:name => "hostgroup") ]
)
```

### Update host
```ruby
zbx.hosts.update(
  :hostid => zbx.hosts.get_id(:host => "hostname"),
  :status => 0
)
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
```

### Delete graph
```ruby
zbx.graphs.delete(zbx.graphs.get_id(:name => "graph"))
```

### Get all templates linked with host
```ruby
zbx.templates.get_ids_by_host( :hostids => [zbx.hosts.get_id(:host => "hostname")] )
returned hash:
{
  "Templatename" => "10",
  "Templatename" => "1021"
}
``` 

### Link host with templates
```ruby
zbx.hosts.unlink_templates(
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

## Zabbix documentation

* Zabbix Project Homepage -> http://zabbix.com/
* Zabbix Api docs -> http://www.zabbix.com/documentation/1.8/api