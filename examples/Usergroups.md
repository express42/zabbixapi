# Usergroups

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Usergroups:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/usergroup](https://www.zabbix.com/documentation/3.2/manual/api/reference/usergroup)

## Create UserGroup, add User and set permission
```ruby
zbx.usergroups.get_or_create(:name => "Some user group")

zbx.usergroups.add_user(
  :usrgrpids => [zbx.usergroups.get_id(:name => "Some user group")],
  :userids => [zbx.users.get_id(:alias => "user")]
)

# set write and read permissions for UserGroup on all Hostgroups
zbx.usergroups.set_perms(
   :usrgrpid => zbx.usergroups.get_or_create(:name => "Some user group"),
   :hostgroupids => zbx.hostgroups.all.values, # kind_of Array
   :permission => 3 # 2- read (by default) and 3 - write and read
)
```
