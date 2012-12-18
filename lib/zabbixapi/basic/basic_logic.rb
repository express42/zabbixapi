class ZabbixApi
  class Basic

    def parse_keys(data)
      case data
        when Hash
          data.empty? ? nil : data[keys][0].to_i 
        when TrueClass
          true
        when FalseClass
          false
        else
          nil
      end
    end

    def merge_params(params)
      result = JSON.generate(default_options).to_s + "," + JSON.generate(params).to_s
      JSON.parse(result.gsub('},{', ','))
    end

    def create(data)
      data_with_default = default_options.empty? ? data : merge_params(data)
      data_create = array_flag ? [data_with_default] : data_with_default
      result = @client.api_request(:method => "#{method_name}.create", :params => data_create)
      parse_keys result
    end

    def delete(data)
      data_delete = array_flag ? [data] : [key.to_sym => data]
      result = @client.api_request(:method => "#{method_name}.delete", :params => data_delete)
      parse_keys result
    end

    def create_or_update(data)
      id = get_id(indentify.to_sym => data[indentify.to_sym])
      id ? update(data.merge(key.to_sym => id)) : create(data)
    end

    def update(data)
      result = @client.api_request(:method => "#{method_name}.update", :params => data)
      parse_keys result
    end

    def get_full_data(data)
      @client.api_request(
        :method => "#{method_name}.get", 
        :params => {
          :filter => {
            indentify.to_sym => data[indentify.to_sym]
          },
          :output => "extend"
          }
        )
    end

    def all
      result = {}
      @client.api_request(:method => "#{method_name}.get", :params => {:output => "extend"}).each do |item|
        result[item[indentify]] = item[key]
      end
      result
    end

    def get_id(data)
      result = get_full_data(data)
      id = nil
      result.each { |item| id = item[key].to_i if item[indentify] == data[indentify.to_sym] }
      id
    end

    def get_or_create(data)
      unless id = get_id(data)
        id = create(data)
      end
      id
    end

  end
end
