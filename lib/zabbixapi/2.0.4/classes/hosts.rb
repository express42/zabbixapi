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
      case @client.api_version
        when "1.2"
          result ? true : false
        else
          result.empty? ? false : true
      end
    end

    def create_or_update(data)
      hostid = get_id(:host => data[:host])
      hostid ? update(data.merge(:hostid => hostid)) : create(data)
    end

  end
end
