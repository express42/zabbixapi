Examples Index
====================

- [Quick Start](README.md#quick-start)
    - [Connect](README.md#connect)
    - [Create Host](README.md#create-host)
    - [Custom Queries](README.md#custom-queries)
- Supported Zabbix Objects
    - [Actions](Actions.md)
    - [Applications](Applications.md)
    - [Configurations](ZabbixObjects.md#configurations)
    - [Graphs](ZabbixObjects.md#graphs)
    - [Hostgroups](ZabbixObjects.md#hostgroups)
    - [Hosts](ZabbixObjects.md#hosts)
    - [Httptests](ZabbixObjects.md#httptests)
    - [Items](ZabbixObjects.md#items)
    - [Maintenance](ZabbixObjects.md#maintenance)
    - [MediaTypes](ZabbixObjects.md#mediatypes)
    - [Proxies](ZabbixObjects.md#proxies)
    - [Screens](ZabbixObjects.md#screens)
    - [Templates](ZabbixObjects.md#templates)
    - [Triggers](ZabbixObjects.md#triggers)
    - [Usergroups](ZabbixObjects.md#usergroups)
    - [Usermacros](ZabbixObjects.md#usermacros)
    - [Users](ZabbixObjects.md#users)

# Quick Start

## Connect

### Standard
```ruby
require "zabbixapi"

zbx = ZabbixApi.connect(
  :url => 'http://localhost/zabbix/api_jsonrpc.php',
  :user => 'Admin',
  :password => 'zabbix'
)
```

### Basic Auth
```ruby
require "zabbixapi"

zbx = ZabbixApi.connect(
  :url => 'http://localhost/zabbix/api_jsonrpc.php',
  :user => 'Admin',
  :password => 'zabbix',
  :http_password => 'foo',
  :http_user => 'bar'
)
```

## Create Host
```ruby
zbx.hosts.create(
  :host => host.fqdn,
  :interfaces => [
    {
      :type => 1,
      :main => 1,
      :ip => '10.0.0.1',
      :dns => 'server.example.org',
      :port => 10050,
      :useip => 0
    }
  ],
  :groups => [ :groupid => zbx.hostgroups.get_id(:name => "hostgroup") ]
)
```

## Custom Queries
```ruby
zbx.query(
  :method => "apiinfo.version",
  :params => {}
)
```
