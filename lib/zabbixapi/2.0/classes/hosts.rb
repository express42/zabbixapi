class ZabbixApi
  class Hosts < Basic

    def array_flag
      true
    end

    def method_name
      "host"
    end

    def indentify
      "host"
    end

    def default_options
      {
        :host => nil,
        :port => 10050,
        :status => 1,
        :useip => 1,
        :dns => '',
        :ip => '0.0.0.0',
        :proxy_hostid => 0,
        :groups => [],
        :useipmi => 0,
        :ipmi_ip => '',
        :ipmi_port => 623,
        :ipmi_authtype => 0,
        :ipmi_privilege => 0,
        :ipmi_username => '',
        :ipmi_password => ''
      }
    end

    def unlink_templates(data)
      result = @client.api_request(
        :method => "host.massRemove",
        :params => {
          :hostids => data[:hosts_id],
          :templates => data[:templates_id]
        }
      )
      result.empty? ? false : true
    end

    def create_or_update(data)
      # https://www.zabbix.com/documentation/2.2/manual/api/reference/host/create
      # interfaces :(
      data_new = data.clone

      data_new[:interfaces] = {}

      %w( type main useip ip dns port ).each do |key|
        data_new[:interfaces][key.to_sym] = data_new[key.to_sym]
      end
      puts "#{data_new.inspect}"
      hostid = get_id(:host => data_new[:host])
      hostid ? update(data_new.merge(:hostid => hostid)) : create(data_new)
    end

  end
end
