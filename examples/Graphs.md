# Graphs

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Graphs:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/graph](https://www.zabbix.com/documentation/3.2/manual/api/reference/graph)

## Create Graph
```ruby
gitems = {
  :itemid => zbx.items.get_id(:name => "item"),
  :calc_fnc => "2",
  :type => "0",
  :periods_cnt => "5"
}

zbx.graphs.create(
  :gitems => [gitems],
  :show_triggers => "0",
  :name => "graph",
  :width => "900",
  :height => "200",
  :hostid => zbx.templates.get_id(:host => "template")
)
```

## Update Graph
```ruby
zbx.graphs.update(
  :graphid => zbx.graphs.get_id(:name => "graph"),
  :ymax_type => 1
)

#Also you can use:
gitems = {
  :itemid => zbx.items.get_id(:name => "item"),
  :calc_fnc => "3",
  :type => "0",
  :periods_cnt => "5"
}
zbx.graphs.create_or_update(
  :gitems => [gitems],
  :show_triggers => "1",
  :name => graph,
  :width => "900",
  :height => "200",
  :hostid => zbx.templates.get_id(:host => "template")
)
```

## Get Graph ids by Host ###
```ruby
zbx.graphs.get_ids_by_host(:host => "hostname")

#You can filter graph name:
zbx.graphs.get_ids_by_host(:host => "hostname", filter => "CPU")
```

## Delete Graph
```ruby
zbx.graphs.delete(zbx.graphs.get_id(:name => "graph"))
```

