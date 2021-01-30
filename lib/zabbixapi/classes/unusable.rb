class ZabbixApi
  class Triggers < Basic
    def create_or_update(data)
      log "[DEBUG] Call create_or_update with parameters: #{data.inspect}"
      get_or_create(data)
    end
  end
end
