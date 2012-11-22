class ZabbixApi
  class Templates

    def initialize(options = {})
      @client = Client.new(options)
      @options = options
    end

    # Create template
    #
    # * *Args*    :
    #   - +data+ -> Hash with :host => "Template_Name" and :groups => array with hostgroup ids
    # * *Returns* :
    #   - Nil or Integer
    def create(data)
      result = @client.api_request(:method => "template.create", :params => [data])
      result.empty? ? nil : result['templateids'][0].to_i
    end

    # Add template
    # Synonym create
    def add(data)
      create(data)
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

    # Destroy template
    # Synonym delete
    def destroy(data)
      delete(data)
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
      unless templateid = get_id(:host => data[:host])
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
          :hosts => data[:hosts_id].map { |t| {:hostid => t} },
          :templates => data[:templates_id].map { |t| {:templateid => t} }
        }
      )
      result.empty? ? false : true      
    end

    # Return all templates
    # 
    # * *Returns* :
    #   - Hash with {"Template_Name1" => "templateid1", "Template_Name2" => "templateid2"}
    def all
      result = {}
      case @client.api_version
        when "1.2"
          @client.api_request(:method => "template.get", :params => {:output => "extend"}).values.each do |tmpl|
            result[tmpl['host']] = tmpl['hostid']
          end          
        else
          @client.api_request(:method => "template.get", :params => {:output => "extend"}).each do |tmpl|
            result[tmpl['host']] = tmpl['hostid']
          end
      end
      result
    end

    # Return info about template
    # 
    # * *Args*    : 
    #   - +data+ -> Hash with :host => "Template name"
    # * *Returns* :
    #   - Hash with template info
    def get_full_data(data)
      case @client.api_version
        when "1.2"
          # in this version returned id=>{...}
          result = @client.api_request(:method => "template.get", :params => {:filter => data, :output => "extend"})
          result.empty? ? [] : result.values 
        else
          @client.api_request(:method => "template.get", :params => {:filter => data, :output => "extend"})
      end
    end

    # Return info about template
    # 
    # * *Args*    : 
    #   - +data+ -> Hash with :host => "Template name"
    # * *Returns* :
    #   - Nil or Integer
    def get_id(data)
      templateid = nil
      get_full_data(data).each { |template| templateid = template['templateid'].to_i if template['host'] == data[:host] }
      templateid
    end

  end
end