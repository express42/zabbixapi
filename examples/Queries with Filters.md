# Queries with zabbixapi

These examples assumes you have already initialized and connected the ZabbixApi and have an object "zbx" that represents this connection.

### Learning with the debug option
If you're just learning how this library works with the zabbix api and you're having trouble understanding what the library is doing as it relates to the zabbix api documentation, you can try enabling the debug option in the client, either when you instantiate it or later on as you desire.  With debug turned on, you can see what zabbixapi has constructed as a query, and you can see the json data that's coming back from zabbix.

#### instantiate w/ debug
``` ruby
zbx = ZabbixApi.connect(url: '<url>', user: '<user>', password: '<passwd>', debug: true)
```

#### debug on demand
``` ruby
zbx.client.options[debug: true]
```

### Listing all objects of a type: "all"

For all object types, you can get a list of all objects of that type that are defined in zabbix by calling 
``` ruby
<objecttype>.all
```
So to get a list of all host groups in your installation you can call
``` ruby
zbx.hostgroups.all
```

### Searching with filters: "get[_*]"

The get() method available for all objects includes some implied logic: the only parameter being sent in is a filter object, and the parameters you provide to this method are properties of that filter.

In general, the get_* methods are wrappers around calls to the get() method that help with construction of particular filters.

As of this writing, a filter object is descrbed in this way:

> Return only those results that exactly match the given filter.
>
> Accepts an array, where the keys are property names, and the values are either a single value or an array of values to match against.
>
> Doesn't work for text fields. 

For instance, to get a list of all the fields you can filter on when using hosts.get_* methods, you can first run

``` ruby
zbx.hosts.get_full_data(host: 'zabbix-server')
```

That call will return a structure like:

``` ruby
[{"hostid"=>"1001",
  "proxy_hostid"=>"0",
  "host"=>"zabbix-server",
  "status"=>"0",
  "disable_until"=>"0",
  "error"=>"",
  "available"=>"1",
  "errors_from"=>"0",
  "lastaccess"=>"0",
  "ipmi_authtype"=>"-1",
  "ipmi_privilege"=>"2",
  "ipmi_username"=>"",
  "ipmi_password"=>"",
  "ipmi_disable_until"=>"0",
  "ipmi_available"=>"0",
  "snmp_disable_until"=>"0",
  "snmp_available"=>"0",
  "maintenanceid"=>"0",
  "maintenance_status"=>"0",
  "maintenance_type"=>"0",
  "maintenance_from"=>"0",
  "ipmi_errors_from"=>"0",
  "snmp_errors_from"=>"0",
  "ipmi_error"=>"",
  "snmp_error"=>"",
  "jmx_disable_until"=>"0",
  "jmx_available"=>"0",
  "jmx_errors_from"=>"0",
  "jmx_error"=>"",
  "name"=>"zabbix-server",
  "flags"=>"0",
  "templateid"=>"0",
  "description"=>"This is the zabbix server",
  "tls_connect"=>"1",
  "tls_accept"=>"1",
  "tls_issuer"=>"",
  "tls_subject"=>"",
  "tls_psk_identity"=>"",
  "tls_psk"=>"",
  "proxy_address"=>"",
  "auto_compress"=>"1"}]
```

Using the information you see in this structure, you can query more specifically like:

``` ruby
zbx.hosts.get_id(host: 'zabbix-server')
```

(which for this call returns a single host id).


### Searches with parameters beyond "filter"

If you want to do queries that use the parameters described in the api for the various object other than just the "filter" one, you'll need to do a custom query.

Custom queries closely mirror what you see in the zabbix api documentation, so it's pretty easy to translate from the offical api documentation to a custom query.

For instance, say that you want get a list of hosts that belong to a host group.  You can construct a custom query like this:

``` ruby
zbx.query(method: 'host.get', params: {groupids: [1,2,3], selectGroups: :extend})
```
and of course you can nest calls:
```ruby
zbx.query(method: 'host.get', params: {groupids: zbx.hostgroups.get_id(name: 'My Hostgroup'), selectGroups: :extend})
```
