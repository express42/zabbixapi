class ZabbixApi
  class Basic

    def hash_equals?(a, b)
      hash1 = a.merge(b)
      hash2 = b.merge(a)
      hash1 == hash2
    end

    def log(message)
      puts "#{message}" if @client.options[:debug]
    end

    def symbolize_keys(obj)
      return obj.inject({}){|memo,(k,v)| memo[k.to_sym] =  symbolize_keys(v); memo} if obj.is_a? Hash
      return obj.inject([]){|memo,v    | memo           << symbolize_keys(v); memo} if obj.is_a? Array
      obj
    end

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

  end
end
