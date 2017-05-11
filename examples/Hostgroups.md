# Hostgroups

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Hostgroups:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/hostgroup](https://www.zabbix.com/documentation/3.2/manual/api/reference/hostgroup)

## Create Hostgroup
```ruby
zbx.hostgroups.create(:name => "hostgroup")
```
