class ZabbixApi
  class Basic

    def create(data)
      log "[DEBUG] Call create with parameters: #{data.inspect}"

      data_with_default = default_options.empty? ? data : merge_params(default_options, data)
      data_create = [data_with_default]
      result = @client.api_request(:method => "#{method_name}.create", :params => data_create)
      parse_keys result
    end

    def delete(data)
      log "[DEBUG] Call delete with parameters: #{data.inspect}"

      data_delete = [data]
      result = @client.api_request(:method => "#{method_name}.delete", :params => data_delete)
      parse_keys result
    end

    def create_or_update(data)
      log "[DEBUG] Call create_or_update with parameters: #{data.inspect}"

      id = get_id(indentify.to_sym => data[indentify.to_sym])
      id ? update(data.merge(key.to_sym => id.to_s)) : create(data)
    end

    def update(data, force=false)
      log "[DEBUG] Call update with parameters: #{data.inspect}"

      dump = {}
      item_id = data[key.to_sym].to_i
      dump_by_id(key.to_sym => data[key.to_sym]).each do |item|
        dump = symbolize_keys(item) if item[key].to_i == data[key.to_sym].to_i
      end

      if hash_equals?(dump, data) and not force
        log "[DEBUG] Equal keys #{dump} and #{data}, skip update"
        item_id
      else
        data_update = [data]
        result = @client.api_request(:method => "#{method_name}.update", :params => data_update)
        parse_keys result
      end

    end

    def get_full_data(data)
      log "[DEBUG] Call get_full_data with parameters: #{data.inspect}"

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

    def get_raw(data)
      log "[DEBUG] Call get_raw with parameters: #{data.inspect}"

      @client.api_request(
        :method => "#{method_name}.get",
        :params => data
      )
    end

    def dump_by_id(data)
      log "[DEBUG] Call dump_by_id with parameters: #{data.inspect}"

      @client.api_request(
        :method => "#{method_name}.get",
        :params => {
          :filter => {
            key.to_sym => data[key.to_sym]
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
      log "[DEBUG] Call get_id with parameters: #{data.inspect}"

      # symbolize keys if the user used string keys instead of symbols
      data = symbolize_keys(data) if data.key?(indentify)
      # raise an error if indentify name was not supplied 
      name = data[indentify.to_sym]
      raise ApiError.new("#{indentify} not supplied in call to get_id") if name == nil
      result = @client.api_request(
        :method => "#{method_name}.get",
        :params => {
          :filter => data,
          :output => [key, indentify]
        }
      )
      id = nil
      result.each { |item| id = item[key].to_i if item[indentify] == data[indentify.to_sym] }
      id
    end

    def get_or_create(data)
      log "[DEBUG] Call get_or_create with parameters: #{data.inspect}"

      unless (id = get_id(indentify.to_sym => data[indentify.to_sym]))
        id = create(data)
      end
      id
    end

  end
end
