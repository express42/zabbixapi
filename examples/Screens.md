# Screens

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Screens:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/screen](https://www.zabbix.com/documentation/3.2/manual/api/reference/screen)

## Create Screen for Host
```ruby
zbx.screens.get_or_create_for_host(
  :screen_name => "screen_name",
  :graphids => zbx.graphs.get_ids_by_host(:host => "hostname")
)
```

## Delete Screen
```ruby
zbx.screens.delete(
  :screen_id => 1, # or screen_id => [1, 2]
)
```

or

```ruby
zbx.screens.delete(
  :screen_name => "foo screen", # or screen_name => ["foo screen", "bar screen"]
)
````
