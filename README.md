# Ruby Zabbix Api Module

Simple and lightweight ruby module for work with zabbix api

[![Build Status](https://travis-ci.org/express42/zabbixapi.png)](https://travis-ci.org/express42/zabbixapi)

##### Now works with all version of zabbix
* 1.8.2 (api version 1.2) /zabbixapi 0.6.x [branch zabbix1.8](https://github.com/express42/zabbixapi/tree/zabbix1.8)
* 1.8.9 (api version 1.3) /zabbixapi 0.6.x [branch zabbix1.8](https://github.com/express42/zabbixapi/tree/zabbix1.8)
* 2.0.x (api version 1.4 -> 2.0.10) /zabbixapi 2.0.x [branch zabbix2.0](https://github.com/express42/zabbixapi/tree/zabbix2.0)
* 2.2.x (api version 2.2.x) /zabbixapi 2.2.x [branch zabbix2.2](https://github.com/express42/zabbixapi/tree/zabbix2.2)
* 2.4.x (api version 2.2.x) /zabbixapi 2.4.x [master or branch zabbix2.4](https://github.com/express42/zabbixapi/)

Because Zabbix 2.4 is a main branch of Zabbix, so master of zabbixapi supports this version of zabbix.

## Version policy

Zabbixapi has next version policy:
* for zabbix 1.8.9 and below you should use zabbixapi 0.6.x
* for zabbix 2.0.x you should use zabbixapi 2.0.y
* for zabbix 2.2.x you should use zabbixapi 2.2.y
* for zabbix 2.4.x you should use zabbixapi 2.4.y

The PATCH (third digit) version of zabbixapi should not correspond to PATCH version of zabbix, for example
zabbixapi-2.0.x should works with all version of zabbix 2.0.y

We support only two last versions of zabbix (2.2 and 2.4), so you should consider zabbixapi 0.6.x and 2.0.x depricated.

## Installation
```
gem install zabbixapi -v 2.4.2
```

## Getting Started

### Connect
```ruby
require "zabbixapi"

zbx = ZabbixApi.connect(
  :url => 'http://localhost/zabbix/api_jsonrpc.php',
  :user => 'Admin',
  :password => 'zabbix'
)
# use basic_auth
zbx = ZabbixApi.connect(
  :url => 'http://localhost/zabbix/api_jsonrpc.php',
  :user => 'Admin',
  :password => 'zabbix',
  :http_password => 'foo',
  :http_user => 'bar'
)
```
### Create Hostgroup
```ruby
zbx.hostgroups.create(:name => "hostgroup")
```

### Create Template
```ruby
zbx.templates.create(
  :host => "template",
  :groups => [:groupid => zbx.hostgroups.get_id(:name => "hostgroup")]
)
```

### Create Application
```ruby
zbx.applications.create(
  :name => application,
  :hostid => zbx.templates.get_id(:host => "template")
)
```

### Create Item
```ruby
zbx.items.create(
  :name => "item",
  :description => "item",
  :key_ => "proc.num[aaa]",
  :type => 6,
  :value_type => 6,
  :hostid => zbx.templates.get_id(:host => "template"),
  :applications => [zbx.applications.get_id(:name => "application")]
)
# or use (lib merge json):
zbx.items.create_or_update(
  :name => "item",
  :description => "item",
  :key_ => "proc.num[aaa]",
  :type => 6,
  :value_type => 4,
  :hostid => zbx.templates.get_id(:host => "template"),
  :applications => [zbx.applications.get_id(:name => "application")]
)
```

### Update Item
```ruby
zbx.items.update(
  :itemid => zbx.items.get_id(:name => "item"),
  :status => 0
)
#You can check item:
puts zbx.items.get_full_data(:name => "item")
```

### Create host
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

### Update host
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


```ruby
zbx.hosts.delete zbx.hosts.get_id(:host => "hostname")
```

### Create graph
```ruby
gitems = {
  :itemid => zbx.items.get_id(:name => "item"),
  :calc_fnc => "2",
  :type => "0",
  :periods_cnt => "5"
}

zbx.graphs.create(
  :gitems => [gitems],
  :show_triggers => "0",
  :name => "graph",
  :width => "900",
  :height => "200"
)
```

### Update graph
```ruby
zbx.graphs.update(
  :graphid => zbx.graphs.get_id(:name => "graph"),
  :ymax_type => 1
)
#Also you can use:
gitems = {
  :itemid => zbx.items.get_id(:name => "item"),
  :calc_fnc => "3",
  :type => "0",
  :periods_cnt => "5"
}
zbx.graphs.create_or_update(
  :gitems => [gitems],
  :show_triggers => "1",
  :name => graph,
  :width => "900",
  :height => "200"
)
```
### Get ids by host ###
```ruby
zbx.graphs.get_ids_by_host(:host => "hostname")
#You can filter graph name:
zbx.graphs.get_ids_by_host(:host => "hostname", filter => "CPU")
```

### Delete graph
```ruby
zbx.graphs.delete(zbx.graphs.get_id(:name => "graph"))
```

### Get all templates linked with host
```ruby
zbx.templates.get_ids_by_host( :hostids => [zbx.hosts.get_id(:host => "hostname")] )
#returned hash:
#{
#  "Templatename" => "10",
#  "Templatename" => "1021"
#}
```

### Mass (Un)Link host with templates
```ruby
zbx.templates.mass_add(
  :hosts_id => [zbx.hosts.get_id(:host => "hostname")],
  :templates_id => [111, 214]
)
zbx.templates.mass_remove(
  :hosts_id => [zbx.hosts.get_id(:host => "hostname")],
  :templates_id => [111, 214]
)
```

### Create trigger
```ruby
zbx.triggers.create(
  :description => "trigger",
  :expression => "{template:proc.num[aaa].last(0)}<1",
  :comments => "Bla-bla is faulty (disaster)",
  :priority => 5,
  :status     => 0,
  :templateid => 0,
  :type => 0
 )
```

### Get trigger with certain filter
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

### Create user
```ruby
zbx.users.create(
  :alias => "Test user",
  :name => "username",
  :surname => "usersername",
  :passwd => "password"
)
```

### Update user
```ruby
zbx.users.update(:userid => zbx.users.get_id(:alias => "user"), :name => "user2")
```

### Delete graph
```ruby
zbx.graphs.delete(zbx.graphs.get_id(:name => "graph"))
```

### Create screen for host  ###
```ruby
zbx.screens.get_or_create_for_host(
  :screen_name => "screen_name",
  :graphids => zbx.graphs.get_ids_by_host(:host => "hostname")
)
```

### Delete screen ###
```ruby
zbx.screens.delete(
  :screen_id => 1, # or screen_id => [1, 2]
)
```

or

```ruby
zbx.screens.delete(
  :screen_name => "foo screen", # or screen_name => ["foo screen", "bar screen"]
)
````

### Create UserGroup, add user and set permission ###
```ruby
zbx.usergroups.get_or_create(:name => "Some user group")
zbx.usergroups.add_user(
  :usrgrpids => [zbx.usergroups.get_id(:name => "Some user group")],
  :userids => [zbx.users.get_id(:alias => "user")]
)
# set write and read permissions for UserGroup on all hostgroups
zbx.usergroups.set_perm(
   :usrgrpid => zbx.usergroups.get_or_create(:name => "Some user group"),
   :hostgroupids => zbx.hostgroups.all.values, # kind_of Array
   :permission => 3 # 2- read (by default) and 3 - write and read
)
```

### Create MediaType and add it to user ###
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

### Update media ###
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

### Create proxy
#### Active proxy
```ruby
zbx.proxies.create(
  :host => "Proxy 1",
  :status => 5
)
```

#### Passive Proxy
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

### Export object

```ruby
zbx.configurations.export(
    :format => "xml",
    :options => {
        :templates => [zbx.templates.get_id(:host => "template")]
    }
)
```

### Import object

```ruby
zbx.configurations.import(
    :format => "xml",
    :rules => {
        :templates => {
            :createMissing => true,
            :updateExisting => true
        },
        :items => {
            :createMissing => true,
            :updateExisting => true
        }
    },
    :source => "<!--?xml version=\"1.0\" encoding=\"UTF-8\"?--><zabbix_export><version>2.0</version><date>2012-04-18T11:20:14Z</date><groups><group><name>Zabbix servers</name></group></groups><hosts><host><host>Export host</host><name>Export host</name><proxyid>0</proxyid><status>0</status><ipmi_authtype>-1</ipmi_authtype><ipmi_privilege>2</ipmi_privilege><ipmi_username></ipmi_username><ipmi_password></ipmi_password><templates></templates><groups><group><name>Zabbix servers</name></group></groups><interfaces><interface><default>1</default><type>1</type><useip>1</useip><ip>127.0.0.1</ip><dns></dns><port>10050</port><interface_ref>if1</interface_ref></interface></interfaces><applications><application><name>Application</name></application></applications><items><item><name>Item</name><type>0</type><snmp_community></snmp_community><multiplier>0</multiplier><snmp_oid></snmp_oid><key>item.key</key><delay>30</delay><history>90</history><trends>365</trends><status>0</status><value_type>3</value_type><allowed_hosts></allowed_hosts><units></units><delta>0</delta><snmpv3_securityname></snmpv3_securityname><snmpv3_securitylevel>0</snmpv3_securitylevel><snmpv3_authpassphrase></snmpv3_authpassphrase><snmpv3_privpassphrase></snmpv3_privpassphrase><formula>1</formula><delay_flex></delay_flex><params></params><ipmi_sensor></ipmi_sensor><data_type>0</data_type><authtype>0</authtype><username></username><password></password><publickey></publickey><privatekey></privatekey><port></port><description></description><inventory_link>0</inventory_link><applications><application><name>Application</name></application></applications><valuemap></valuemap><interface_ref>if1</interface_ref></item></items><discovery_rules></discovery_rules><macros></macros><inventory></inventory></host></hosts><triggers><trigger><expression>{Export host:item.key.last(0)}=0</expression><name>Trigger</name><url></url><status>0</status><priority>2</priority><description>Host trigger</description><type>0</type><dependencies></dependencies></trigger></triggers><graphs><graph><name>Graph</name><width>900</width><height>200</height><yaxismin>0.0000</yaxismin><yaxismax>100.0000</yaxismax><show_work_period>1</show_work_period><show_triggers>1</show_triggers><type>0</type><show_legend>1</show_legend><show_3d>0</show_3d><percent_left>0.0000</percent_left><percent_right>0.0000</percent_right><ymin_type_1>0</ymin_type_1><ymax_type_1>0</ymax_type_1><ymin_item_1>0</ymin_item_1><ymax_item_1>0</ymax_item_1><graph_items><graph_item><sortorder>0</sortorder><drawtype>0</drawtype><color>C80000</color><yaxisside>0</yaxisside><calc_fnc>7</calc_fnc><type>0</type><item><host>Export host</host><key>item.key</key></item></graph_item></graph_items></graph></graphs></zabbix_export>"
)
```

### User and global macros
```ruby
zbx.usermacros.create(
    :hostid => zbx.hosts.get_id( :host => "Zabbix server" ),
    :macro => "{$ZZZZ}",
    :value => 1.1.1.1
)
```

### Custom queries
```ruby
zbx.query(
  :method => "apiinfo.version",
  :params => {}
)
```

## Dependencies

* net/http
* net/https
* json

## Contributing

* Fork the project.
* Make your feature addition or bug fix, write tests.
* Commit, do not mess with rakefile, version.
* Make a pull request.

## Zabbix documentation

* [Zabbix Project Homepage](http://zabbix.com/)
* [Zabbix Api docs](https://www.zabbix.com/documentation/2.4/manual/api/reference)
