class ZabbixApi
  class Templates < Basic

    def array_flag
      true
    end

    def method_name
      "template"
    end

    def indentify
      "host"
    end


    # Delete template
    #
    # * *Args*    :
    #   - +data+ -> Hash with :host => "Template_Name"
    # * *Returns* :
    #   - Nil or Integer
    def delete(data)
      result = @client.api_request(:method => "template.delete", :params => [:templateid => data])
      result.empty? ? nil : result['templateids'][0].to_i
    end

    # Return templateids linked with host 
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :hostids => [hostid]
    # * *Returns* :
    #   - Array with templateids
    def get_ids_by_host(data)
      result = []
      @client.api_request(:method => "template.get", :params => data).each do |tmpl|
        result << tmpl['templateid']
      end
      result
    end

    # Return templateid
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :host => "Template_Name" and :groups => array with hostgroup ids
    # * *Returns* :
    #   - Integer
    def get_or_create(data)
      unless (templateid = get_id(:host => data[:host]))
        templateid = create(data)
      end
      templateid
    end   

    # Analog Zabbix api call massUpdate
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :hosts_id => [hostid1, hostid2 ...], and :templates_id => [templateid1, templateid2 ...]
    # * *Returns* :
    #   - True or False
    def mass_update(data)
      result = @client.api_request(
        :method => "template.massAdd", 
        :params => {
          :hosts => data[:hosts_id].map { |t| {:hostid => t} },
          :templates => data[:templates_id].map { |t| {:templateid => t} }
        }
      )
      result.empty? ? false : true
    end

    # Analog Zabbix api call massAdd 
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :hosts_id => [hostid1, hostid2 ...], and :templates_id => [templateid1, templateid2 ...]
    # * *Returns* :
    #   - True or False
    def mass_add(data)
      result = @client.api_request(
        :method => "template.massAdd", 
        :params => {
          :hosts => data[:hosts_id].map { |t| {:hostid => t} },
          :templates => data[:templates_id].map { |t| {:templateid => t} }
        }
      )
      result.empty? ? false : true
    end

    # Analog Zabbix api call massRemove
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :hosts_id => [hostid1, hostid2 ...], and :templates_id => [templateid1, templateid2 ...]
    # * *Returns* :
    #   - True or False
    def mass_remove(data)
      result = @client.api_request(
        :method => "template.massRemove", 
        :params => {
          :hostids => data[:hosts_id],
          :templateids => data[:templates_id],
          :groupids => data[:group_id],
          :force => 1
        }
      )
      result.empty? ? false : true      
    end

  end
end
