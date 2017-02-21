# Hosts

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Hosts:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/host](https://www.zabbix.com/documentation/3.2/manual/api/reference/host)

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

#or use:
zbx.hosts.create_or_update(
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

## Update Host
```ruby
zbx.hosts.update(
  :hostid => zbx.hosts.get_id(:host => "hostname"),
  :status => 0
)

#You can check host:
puts zbx.hosts.get_full_data(:host => "hostname")

# Zabbixapi checks that new object differ from one in zabbix. But if you
# want to update nested arguments (like interfaces), you should use second argument. 
# For example:

zbx.hosts.update({
  :hostid => zbx.hosts.get_id(:host => "hostname"),
  :interfaces => [
    {
      :type => 1,
      :main => 1,
      :ip => '10.0.0.1',
      :dns => 'server.example.org',
      :port => 10050,
      :useip => 0
    }
  ]}, true)
```

## Delete Host
```ruby
zbx.hosts.delete zbx.hosts.get_id(:host => "hostname")
```
