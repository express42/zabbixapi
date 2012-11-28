class ZabbixApi
  class Hosts < Basic

    def api_method_name
      "host"
    end

    def api_identify
      "host"
    end

    def initialize(client)
      @client = client
      @host_default_options = {
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

    def merge_params(params)
      result = JSON.generate(@host_default_options).to_s + "," + JSON.generate(params).to_s
      JSON.parse(result.gsub('},{', ','))
    end

    def create(data)
      result = @client.api_request(:method => "host.create", :params => [merge_params(data)])
      result.empty? ? nil : result['hostids'][0].to_i
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

    def delete(data)
      delete_array_sym(data)
    end


    def get_full_data(data)
      get_full_data_filter(data)
    end

  end
end
