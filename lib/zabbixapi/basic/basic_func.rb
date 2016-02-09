class ZabbixApi
  class Basic

    def log(message)
      puts "#{message}" if @client.options[:debug]
    end

    def hash_equals?(a, b)
      a_new = normalize_obj(a)
      b_new = normalize_obj(b)
      hash1 = a_new.merge(b_new)
      hash2 = b_new.merge(a_new)
      hash1 == hash2
    end

    def symbolize_keys(obj)
      return obj.inject({}){|memo,(k,v)| memo[k.to_sym] =  symbolize_keys(v); memo} if obj.is_a? Hash
      return obj.inject([]){|memo,v    | memo           << symbolize_keys(v); memo} if obj.is_a? Array
      obj
    end

    def normalize_obj(obj)
      obj.delete(:hostid) #TODO remove to logig. TemplateID and HostID has different id
      case obj
        when Hash
          result = obj.dup
          result.each do |key, value|
            case value
              when Array
                result[key] = normalize_obj(value)
              when Hash
                result[key] = normalize_obj(value)
              else
                result[key] = value.to_s
            end
          end
          result.sort
        when Array
          result = obj.dup
          result.collect { |item| normalize_hash(item) }
          result.sort
        else
          result = obj
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

    def merge_params(a, b)
      new = a.dup
      new.merge(b)
    end

  end
end
