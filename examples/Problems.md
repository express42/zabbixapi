# Problems

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for MediaTypes:
[https://www.zabbix.com/documentation/5.2/manual/api/reference/problem](https://www.zabbix.com/documentation/5.2/manual/api/reference/problem)

## Get Problems
Problem Zabbix API object does not have unique identifier, but search can be
filtered by `name`, and/or one of the following:
- `eventids`: Return only problems with the given IDs.
- `groupids`: Return only problems created by objects that belong to the given
  host groups.
- `hostids`: Return only problems created by objects that belong to the given
  hosts.
- `objectids`: Return only problems created by the given objects.
- `applicationids`: Return only problems created by objects that belong to the
  given applications. Applies only if object is trigger or item.
- `tags`: Return only problems with given tags. Exact match by tag and
  case-insensitive search by value and operator.

```ruby
zbx.problems.dump_by_id(
  name: "Zabbix agent is not available (for 3m)"
)

zbx.problems.get(eventids: "86")
zbx.problems.get(objectids: "17884")
```

## Get all Problems
```ruby
zbx.problems.all
```
