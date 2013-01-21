class ZabbixApi
  class Basic

    def log(message)
      puts "#{message}" if @client.options[:debug]
    end

    def hash_equals?(a, b)
      a_new = normalize_hash(a)
      b_new = normalize_hash(b)
      hash1 = a_new.merge(b_new)
      hash2 = b_new.merge(a_new)
      hash1 == hash2
    end

    def symbolize_keys(obj)
      return obj.inject({}){|memo,(k,v)| memo[k.to_sym] =  symbolize_keys(v); memo} if obj.is_a? Hash
      return obj.inject([]){|memo,v    | memo           << symbolize_keys(v); memo} if obj.is_a? Array
      obj
    end

    def normalize_hash(hash)
      result = hash.dup
      result.delete(:hostid) #TODO remove to logig. TemplateID and HostID has different id 
      result.each do |key, value|
        case value
          when Array
            result.delete(key)
          else
            result[key] = value.to_s
        end
      end
      result
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
