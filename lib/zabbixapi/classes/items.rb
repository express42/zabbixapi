class ZabbixApi
  class Items < Basic

    def method_name
      "item"
    end

    def indentify
      "name"
    end

    def default_options
      {
        :name => nil,
        :key_ => nil,
        :hostid => nil,
        :delay => 60,
        :history => 60,
        :status => 0,
        :type => 7,
        :snmp_community => '',
        :snmp_oid => '',
        :value_type => 3,
        :data_type => 0,
        :trapper_hosts => 'localhost',
        :snmp_port => 161,
        :units => '',
        :multiplier => 0,
        :delta => 0,
        :snmpv3_securityname => '',
        :snmpv3_securitylevel => 0,
        :snmpv3_authpassphrase => '',
        :snmpv3_privpassphrase => '',
        :formula => 0,
        :trends => 365,
        :logtimefmt => '',
        :valuemapid => 0,
        :delay_flex => '',
        :authtype => 0,
        :username => '',
        :password => '',
        :publickey => '',
        :privatekey => '',
        :params => '',
        :ipmi_sensor => ''
      }
    end

    def create_or_update(data)
      itemid = get_id(:name => data[:name], :hostid => data[:hostid])
      itemid ? update(data.merge(:itemid => itemid)) : create(data)
    end

  end
end
