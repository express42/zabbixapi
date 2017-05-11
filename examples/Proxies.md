# Proxies

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Proxies:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/proxy](https://www.zabbix.com/documentation/3.2/manual/api/reference/proxy)

## Create Proxy

### Active Proxy
```ruby
zbx.proxies.create(
  :host => "Proxy 1",
  :status => 5
)
```

### Passive Proxy
```ruby
zbx.proxies.create(
  :host => "Passive proxy",
  :status => 6,
  :interfaces => [
    :ip => "127.0.0.1",
    :dns => "",
    :useip => 1,
    :port => 10051
  ]
)
```
