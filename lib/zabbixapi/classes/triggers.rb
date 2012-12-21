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

    def create_or_update(data)
      raise "Don't use this shit, use get_or_create"
    end

  end
end
