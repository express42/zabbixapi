class ZabbixApi
  class Basic

    def create(data)
      puts "[DEBUG] Call create with parametrs: #{data.inspect}" if @client.options[:debug]

      data_with_default = default_options.empty? ? data : merge_params(data)
      data_create = array_flag ? [data_with_default] : data_with_default
      result = @client.api_request(:method => "#{method_name}.create", :params => data_create)
      parse_keys result
    end

    def delete(data)
      puts "[DEBUG] Call delete with parametrs: #{data.inspect}" if @client.options[:debug]

      data_delete = array_flag ? [data] : [key.to_sym => data]
      result = @client.api_request(:method => "#{method_name}.delete", :params => data_delete)
      parse_keys result
    end

    def create_or_update(data)
      puts "[DEBUG] Call create_or_update with parametrs: #{data.inspect}" if @client.options[:debug]
      id = get_id(indentify.to_sym => data[indentify.to_sym])
      id ? update(data.merge(key.to_sym => id.to_s)) : create(data)
    end

    def update(data)
      puts "[DEBUG] Call update with parametrs: #{data.inspect}" if @client.options[:debug]
      
      dump = {}
      item_id = data[key.to_sym].to_i
      dump_by_id(key.to_sym => data[key.to_sym]).each do |item|
        dump = symbolize_keys(item) if item[key].to_i == data[key.to_sym].to_i
      end

      unless dump.deep_include?(data, key.to_sym)
        result = @client.api_request(:method => "#{method_name}.update", :params => data)
        parse_keys result
      else
        item_id
      end

    end

    def get_full_data(data)
      puts "[DEBUG] Call get_full_data with parametrs: #{data.inspect}" if @client.options[:debug]

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

    def dump_by_id(data)
      puts "[DEBUG] Call dump_by_id with parametrs: #{data.inspect}" if @client.options[:debug]

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
      puts "[DEBUG] Call get_id with parametrs: #{data.inspect}" if @client.options[:debug]

      result = symbolize_keys( get_full_data(data) )
      id = nil
      result.each { |item| id = item[key.to_sym].to_i if item[indentify.to_sym] == data[indentify.to_sym] }
      id
    end

    def get_or_create(data)
      puts "[DEBUG] Call get_or_create with parametrs: #{data.inspect}" if @client.options[:debug]
      
      unless id = get_id(data)
        id = create(data)
      end
      id
    end

  end
end
