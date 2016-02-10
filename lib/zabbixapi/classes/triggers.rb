class ZabbixApi
  class Triggers < Basic

    def array_flag
      true
    end

    def method_name
      "trigger"
    end

    def indentify
      "description"
    end

    def dump_by_id(data)
      log "[DEBUG] Call dump_by_id with parametrs: #{data.inspect}"

      @client.api_request(
        :method => "trigger.get",
        :params => {
          :filter => {
            key.to_sym => data[key.to_sym]
          },
          :output => "extend",
          :select_items => "extend",
          :select_functions => "extend"
        }
      )
    end

    def safe_update(data)
      log "[DEBUG] Call update with parametrs: #{data.inspect}"

      dump = {}
      item_id = data[key.to_sym].to_i
      dump_by_id(key.to_sym => data[key.to_sym]).each do |item|
        dump = symbolize_keys(item) if item[key].to_i == data[key.to_sym].to_i
      end

      expression = dump[:items][0][:key_]+"."+dump[:functions][0][:function]+"("+dump[:functions][0][:parameter]+")"
      dump[:expression] = dump[:expression].gsub(/\{(\d*)\}/,"{#{expression}}") #TODO ugly regexp
      dump.delete(:functions)
      dump.delete(:items)

      old_expression = data[:expression]
      data[:expression] = data[:expression].gsub(/\{.*\:/,"{") #TODO ugly regexp
      data.delete(:templateid)

      log "[DEBUG] expression: #{dump[:expression]}\n data: #{data[:expression]}"

      dump.delete(key.to_sym)
      data.delete(key.to_sym)
      if hash_equals?(dump, data)
        log "[DEBUG] Equal keys #{dump} and #{data}, skip update"
        item_id
      else
        data[key.to_sym] = item_id
        data[:expression] = old_expression
        # disable old trigger
        log "[DEBUG] disable :" + @client.api_request(:method => "#{method_name}.update", :params => [{:triggerid=> data[:triggerid], :status => "1" }]).inspect
        # create new trigger
        data.delete(:triggerid)
        create(data)
      end

    end

  end
end
