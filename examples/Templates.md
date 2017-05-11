# Templates

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Templates:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/template](https://www.zabbix.com/documentation/3.2/manual/api/reference/template)

## Create Template
```ruby
zbx.templates.create(
  :host => "template",
  :groups => [:groupid => zbx.hostgroups.get_id(:name => "hostgroup")]
)
```

## Mass (Un)Link Host with Templates
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

## Get all Templates linked with Host
```ruby
zbx.templates.get_ids_by_host( :hostids => [zbx.hosts.get_id(:host => "hostname")] )
#returned array:
#[
#   "10",
#   "1021"
#]
```
