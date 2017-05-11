# Maintenance

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Maintenance:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/maintenance](https://www.zabbix.com/documentation/3.2/manual/api/reference/maintenance)

## Create Maintenance
```ruby
zbx.maintenance.create(
  :name => @maintenance,
  :groupids => [ zbx.hostgroups.get_id(:name => "hostgroup") ],
  :active_since => 1358844540,
  :active_till => 1390466940,
  :timeperiods => [ :timeperiod_type => 3, :every => 1, :dayofweek => 64, :start_time => 64800, :period => 3600 ]
)
```
