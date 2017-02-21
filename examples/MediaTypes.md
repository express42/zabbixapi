# MediaTypes

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for MediaTypes:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/mediatype](https://www.zabbix.com/documentation/3.2/manual/api/reference/mediatype)

## Create MediaType and add it to user ###
```ruby
zbx.mediatypes.create_or_update(
  :description => "mediatype",
  :type => 0, # 0 - Email, 1 - External script, 2 - SMS, 3 - Jabber, 100 - EzTexting,
  :smtp_server => "127.0.0.1",
  :smtp_email => "zabbix@test.com"
)

zbx.users.add_medias(
  :userids => [zbx.users.get_id(:alias => "user")],
  :media => [
    {
      :mediatypeid => zbx.mediatypes.get_id(:description => "mediatype"),
      :sendto => "test@test",
      :active => 0,
      :period => "1-7,00:00-24:00", # 1-7 days and 00:00-24:00 hours
      :severity => "56"
    }
  ]
)
```

## Update Media ###
```ruby
zbx.users.update_medias(
  :userids => [zbx.users.get_id(:alias => "user")],
  :media => [
    {
      :mediatypeid => zbx.mediatypes.get_id(:description => "mediatype"),
      :sendto => "test@test",
      :active => 0,
      :period => "1-7,00:00-24:00", # 1-7 days and 00:00-24:00 hours
      :severity => "56"
    }
  ]
)
```
