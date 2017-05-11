# Triggers

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Triggers:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/trigger](https://www.zabbix.com/documentation/3.2/manual/api/reference/trigger)

## Create Trigger
```ruby
zbx.triggers.create(
  :description => "trigger",
  :expression => "{template:proc.num[aaa].last(0)}<1",
  :comments => "Bla-bla is faulty (disaster)",
  :priority => 5,
  :status     => 0,
  :hostid => zbx.templates.get_id(:host => "template"),
  :type => 0,
  :tags => [
    {
      :tag => "process",
      :value => "aaa"
    },
    {
      :tag => "error",
      :value => ""
    }
  ]
)
```

## Get Trigger with certain filter
```ruby
triggers = zbx.query(
  :method => "trigger.get",
  :params => {
    :filter => {
      :url => ""
    },
    :templated => true,
    :output => "extend"
  }
)
```
