class ZabbixApi
  class Basic

    def get(data)
      get_full_data(data)
    end

    def add(data)
      create(data)
    end

    def destroy(data)
      delete(data)
    end

    def method_name
      
    end

  end
end
