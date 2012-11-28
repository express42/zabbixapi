class ZabbixApi
  class Basic

    def initialize(client)
      @client = client
    end

####### Synonyms #########
    def add(data)
      create(data)
    end

    def destroy(data)
      delete(data)
    end

    def dump(data)
      get_full_data(data)
    end

##########################

####### Methods ##########
    def create_array(data)
      result = @client.api_request(:method => "#{api_method_name}.create", :params => [data])
      result.empty? ? nil : result[api_keys][0].to_i
    end

    def create(data)
      result = @client.api_request(:method => "#{api_method_name}.create", :params => data)
      result.empty? ? nil : result[api_keys][0].to_i
    end

    def delete_array(data)
      result = @client.api_request(:method => "#{api_method_name}.delete", :params => [data])
      result.empty? ? nil : result[api_keys][0].to_i
    end

    def delete_array_sym(data)
      result = @client.api_request(:method => "#{api_method_name}.delete", :params => [api_key.to_sym => data])
      result.empty? ? nil : result[api_keys][0].to_i
    end    

    def delete(data)
      result = @client.api_request(:method => "#{api_method_name}.delete", :params => data)
      result.empty? ? nil : result[api_keys][0].to_i
    end

    def update(data)
      result = @client.api_request(:method => "#{api_method_name}.update", :params => data)
      result.empty? ? nil : result[api_keys][0].to_i
    end

    def get_full_data_filter(data)
      @client.api_request(:method => "#{api_method_name}.get", :params => {:filter => data, :output => "extend"})
    end

    def get_full_data_filter_array(data)
      @client.api_request(:method => "#{api_method_name}.get", :params => {:filter => [data[api_identify.to_sym]], :output => "extend"})
    end

    def get_id(data)
      result = get_full_data(data)
      id = nil
      result.each { |tmpl| id = tmpl[api_key].to_i if tmpl[api_identify] == data[api_identify.to_sym] }
      id
    end

    def get_or_create(data)
      id = get_id(data)
      if id.nil?
        id = create(data)
      end
      id
    end

    def create_or_update(data)
      id = get_id(api_identify.to_sym => data[api_identify.to_sym], :templateid => data[:templateid])
      id ? update(data.merge(api_key.to_sym => id)) : create(data)
    end

    def all
      result = {}
      @client.api_request(:method => "#{api_method_name}.get", :params => {:output => "extend"}).each do |tmpl|
        result[tmpl[api_identify]] = tmpl[api_key]
      end
      result      
    end

##########################

    def api_method_name
      raise "Can't call here api_method_name"
    end

    def api_identify
      raise "Can't call here api_identify"
    end

    def api_keys
      api_key + "s"
    end

    def api_key
      api_method_name + "id"
    end

  end
end
