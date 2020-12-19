# Queries with Filters

These examples assumes you have already initialized and connected the ZabbixApi.

### all

For all object types, you can get a list of all objects of that type that are defined in zabbix by calling 
``` ruby
<objecttype>.all
```
So to get a list of all host groups in your installation you can call
``` ruby
zbx.hostgroups.all
```

### Implied filter within get_*

Many of the get_* methods for all the various object types implicitly include a wrapper around the "filter" object.  Filter usage (as of this writing) is described in each applicable get function's documentation as:


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


