# Valuemaps

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Users:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/valuemap](https://www.zabbix.com/documentation/3.2/manual/api/reference/valuemap)

## Create Valuemap
```ruby
zbx.valuemaps.create_or_update(
  :name => "Test valuemap",
  "mappings" => [
    "newvalue" => "newvalue",
    "value" => "value"
	]
)
```

## Delete Valuemap
```ruby
zbx_client.valuemaps.delete(
  zbx.valuemaps.get_id(:name => "Test valuemap")
)
```