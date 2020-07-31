# Hosts

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Hosts:
[https://www.zabbix.com/documentation/4.0/manual/api/reference/host](https://www.zabbix.com/documentation/4.0/manual/api/reference/host)

## Create Host
```ruby
zbx.hosts.create(
  :host => host.fqdn,
  :interfaces => [
    {
      :type => 1,
      :main => 1,
      :ip => '10.0.0.1',
      :dns => 'server.example.org',
      :port => 10050,
      :useip => 0
    }
  ],
  :groups => [ :groupid => zbx.hostgroups.get_id(:name => "hostgroup") ]
)

#or use:
zbx.hosts.create_or_update(
  :host => host.fqdn,
  :interfaces => [
    {
      :type => 1,
      :main => 1,
      :ip => '10.0.0.1',
      :dns => 'server.example.org',
      :port => 10050,
      :useip => 0
    }
  ],
  :groups => [ :groupid => zbx.hostgroups.get_id(:name => "hostgroup") ]
)
```

## Add SNMP Bulk Hosts
hosts = [
  { :group=>"Discovered Hosts", :hostname=>"zabbix", :ip => "127.0.0.1", :community_string=>"public", :template=>"123" },
  { :group=>"Discovered Hosts", :hostname=>"zabbix", :ip => "127.0.0.1", :community_string=>"public", :template=>"123" }
]

hosts.each do |h|
  zbx.hosts.create_or_update(
    :host => h[:hostname],
    :interfaces => [
      {
        :type => 2,
        :main => 1,
        :useip => 1,
        :ip => h[:ip],
        :dns => "",
        :port => 161,
        :details => {
          :version => 2,
          :community => "{$SNMP_COMMUNITY}"
        }
      }
    ],
    :groups => [ :groupid => zbx.hostgroups.get_id(:name => h[:group]) ],
    :templates => [
        {
            :templateid => h[:template]
        }
    ],
    :inventory_mode => 1,
    :macros => [
        {
            :macro => "{$SNMP_COMMUNITY}",
            :value => h[:community_string]
        }
    ]
  )
end

## Update Host
```ruby
zbx.hosts.update(
  :hostid => zbx.hosts.get_id(:host => "hostname"),
  :status => 0
)

#You can check host:
puts zbx.hosts.get_full_data(:host => "hostname")

# Zabbixapi checks that new object differ from one in zabbix. But if you
# want to update nested arguments (like interfaces), you should use second argument. 
# For example:

zbx.hosts.update({
  :hostid => zbx.hosts.get_id(:host => "hostname"),
  :interfaces => [
    {
      :type => 1,
      :main => 1,
      :ip => '10.0.0.1',
      :dns => 'server.example.org',
      :port => 10050,
      :useip => 0
    }
  ]}, true)
```


## Get Host by id (See URL)
```ruby
zbx.hosts.dump_by_id(:hostid => get_id(:host => "hostname"))
```

## Delete Host
```ruby
zbx.hosts.delete zbx.hosts.get_id(:host => "hostname")
```
