class ZabbixApi
  class Applications < Basic

    API_PARAMETERS = %w(applicationids groupids hostids inherited itemids templated templateids selectItems)

    def method_name
      "application"
    end

    def indentify
      "name"
    end

    def get_or_create(data)
      log "[DEBUG] Call get_or_create with parameters: #{data.inspect}"

      unless (id = get_id(:name => data[:name], :hostid => data[:hostid]))
        id = create(data)
      end
      id
    end

    def create_or_update(data)
      applicationid = get_id(:name => data[:name], :hostid => data[:hostid])
      applicationid ? update(data.merge(:applicationid => applicationid)) : create(data)
    end

  end
end
