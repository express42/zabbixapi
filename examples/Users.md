# Users

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Users:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/user](https://www.zabbix.com/documentation/3.2/manual/api/reference/user)

## Create User
```ruby
zbx.users.create(
  :alias => "Test user",
  :name => "username",
  :surname => "usersername",
  :passwd => "password"
)
```

## Update User
```ruby
zbx.users.update(:userid => zbx.users.get_id(:alias => "user"), :name => "user2")
```
