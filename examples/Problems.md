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
- `eventid_from`: Return only problems with IDs greater or equal to the given
  ID.
- `eventid_till`: Return only problems with IDs less or equal to the given ID.
- `time_from`: Return only problems that have been created after or at the given
  time.
- `time_till`: Return only problems that have been created before or at the
  given time.

See Zabbix API documentation for more details.

```ruby
# selecting by name (which is not unique)
zbx.problems.dump_by_id(
  name: "Zabbix agent is not available (for 3m)"
)

# selecting by source eventids
zbx.problems.get(eventids: "86")

# selecting by source objectids
zbx.problems.get(objectids: "17884")

# selecting by timestamp
zbx.problems.get(time_from: 1611928989)
zbx.problems.get(time_till: 1611928989)
```

## Get all Problems
```ruby
zbx.problems.all
```
