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
        :interfaces => [],
        :status => 0,
        :available => 1,
        :groups => [],
        :proxy_hostid => nil
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

    def create_or_update(data, force = false)
      hostid = get_id(:host => data[:host])
      hostid ? update(data.merge(:hostid => hostid), force) : create(data)
    end

    # to make delete call idempotent for all resources
    def delete(hostid)
      super(:hostid => hostid)
    end
  end
end
