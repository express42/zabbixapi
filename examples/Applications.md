# Applications

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Applications:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/application](https://www.zabbix.com/documentation/3.2/manual/api/reference/application)

## Create Application
```ruby
zbx.applications.create(
  :name => application,
  :hostid => zbx.templates.get_id(:host => "template")
)
```
