class ZabbixApi
  class HostGroups < Basic

    def method_name
      "hostgroup"
    end

    def indentify
      "name"
    end

    def key
      "groupid"
    end
  end
end
