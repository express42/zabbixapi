# Items

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Items:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/item](https://www.zabbix.com/documentation/3.2/manual/api/reference/item)

## Create Item
```ruby
zbx.items.create(
  :name => "item",
  :description => "item",
  :key_ => "proc.num[aaa]",
  :type => 6,
  :value_type => 6,
  :hostid => zbx.templates.get_id(:host => "template"),
  :applications => [zbx.applications.get_id(:name => "application")]
)

# or use (lib merge json):
zbx.items.create_or_update(
  :name => "item",
  :description => "item",
  :key_ => "proc.num[aaa]",
  :type => 6,
  :value_type => 4,
  :hostid => zbx.templates.get_id(:host => "template"),
  :applications => [zbx.applications.get_id(:name => "application")]
)
```

## Update Item
```ruby
zbx.items.update(
  :itemid => zbx.items.get_id(:name => "item"),
  :status => 0
)

#You can check Item:
puts zbx.items.get_full_data(:name => "item")
```
