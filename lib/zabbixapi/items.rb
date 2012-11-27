class ZabbixApi
  class Items

    def initialize(client)
      @client = client
      @item_default_options = {
        :description => nil,
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

    def merge_params(params)
      result = JSON.generate(@item_default_options).to_s + "," + JSON.generate(params).to_s
      JSON.parse(result.gsub('},{', ','))
    end

    def create(data)
      result = @client.api_request(:method => "item.create", :params => [merge_params(data)] )
      result.empty? ? nil : result['itemids'][0].to_i
    end

    def add(data)
      create(data)
    end    

    def get_full_data(data)
      @client.api_request(:method => "item.get", :params => {:filter => data, :output => "extend"})
    end

    def get_id(data)
      result = get_full_data(data)
      itemid = nil
      result.each { |item| itemid = item['itemid'].to_i if item['name'] == data[:name] }
      itemid
    end

    def create_or_update(data)
      itemid = get_id(:description => data[:description], :hostid => data[:hostid])
      itemid ? update(data.merge(:itemid => itemid)) : create(data)
    end

    def update(data)
      result = @client.api_request(:method => "item.update", :params => data)
      result.empty? ? nil : result['itemids'][0].to_i
    end

    def delete(data)
      result = @client.api_request(:method => "item.delete", :params => [data])
      result.empty? ? nil : result['itemids'][0].to_i
    end

    def destroy(data)
      delete(data)
    end

  end
end
