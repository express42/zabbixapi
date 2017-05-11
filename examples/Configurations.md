# Configurations

This example assumes you have already initialized and connected the ZabbixApi.

For more information and available properties please refer to the Zabbix API documentation for Configurations:
[https://www.zabbix.com/documentation/3.2/manual/api/reference/configuration](https://www.zabbix.com/documentation/3.2/manual/api/reference/configuration)

## Export Configuration

```ruby
zbx.configurations.export(
    :format => "xml",
    :options => {
        :templates => [zbx.templates.get_id(:host => "template")]
    }
)
```

## Import Configuration

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
