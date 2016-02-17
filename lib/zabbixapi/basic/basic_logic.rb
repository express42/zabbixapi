class ZabbixApi
  class Basic

    def create(data)
      log "[DEBUG] Call create with parametrs: #{data.inspect}"

      data_with_default = default_options.empty? ? data : merge_params(default_options, data)
      data_create = array_flag ? [data_with_default] : data_with_default
      result = @client.api_request(:method => "#{method_name}.create", :params => data_create)
      parse_keys result
    end

    def delete(data)
      log "[DEBUG] Call delete with parametrs: #{data.inspect}"

      data_delete = array_flag ? [data] : [key.to_sym => data]
      result = @client.api_request(:method => "#{method_name}.delete", :params => data_delete)
      parse_keys result
    end

    def create_or_update(data, force = false)
      log "[DEBUG] Call create_or_update with parametrs: #{data.inspect}"

      id = get_id(indentify.to_sym => data[indentify.to_sym])
      id ? update(data.merge(key.to_sym => id.to_s), force) : create(data)
    end

    def update(data, force = false)
      log "[DEBUG] Call update with parametrs: #{data.inspect}"

      dump = {}
      item_id = data[key.to_sym].to_i
      dump_by_id(key.to_sym => data[key.to_sym]).each do |item|
        dump = symbolize_keys(item) if item[key].to_i == data[key.to_sym].to_i
      end

      dump.delete(key.to_sym)
      data.delete(key.to_sym)

      if hash_equals?(dump, data) && !force
        log "[DEBUG] Equal keys #{dump} and #{data}, skip update"
        item_id
      else
        data[key.to_sym] = item_id
        data_update = array_flag ? [data] : data
        result = @client.api_request(:method => "#{method_name}.update", :params => data_update)
        parse_keys result
      end

    end

    def get_full_data(data)
      log "[DEBUG] Call get_full_data with parametrs: #{data.inspect} and params #{data[:params]}"

      data[:params] ||= {}
      res = @client.api_request(
        :method => "#{method_name}.get",
        :params => {
          :filter => {
            indentify.to_sym => data[indentify.to_sym]
          },
          :output => "extend"
        }.merge(data[:params])
      )
      res
    end

    def dump_by_id(data)
      log "[DEBUG] Call dump_by_id with parametrs: #{data.inspect} and params #{data[:params]}"

      data[:params] ||= {}
      @client.api_request(
        :method => "#{method_name}.get",
        :params => {
          :filter => {
            key.to_sym => data[key.to_sym]
          },
          :output => "extend"
        }.merge(data[:params])
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
      log "[DEBUG] Call get_id with parametrs: #{data.inspect}"

      result = symbolize_keys( get_full_data(data) )
      id = nil
      result.each { |item| id = item[key.to_sym].to_i if item[indentify.to_sym].to_s == data[indentify.to_sym].to_s }
      id
    end

    def get_or_create(data)
      log "[DEBUG] Call get_or_create with parametrs: #{data.inspect}"

      unless (id = get_id(data))
        id = create(data)
      end
      id
    end

  end
end
