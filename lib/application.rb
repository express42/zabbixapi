require 'base'

module Zabbix
  class ZabbixApi
    def add_application(app_options)

      app_options_default = {
        'hostid' => nil,
        'name' => nil
      }

      application = merge_opt(app_options_default, app_options)
      message = {
        'method' => 'application.create',
        'params' => application
      }

      responce = send_request(message)

      if not ( responce.empty? ) then
        result = responce['applicationids'][0].to_i
      else
        result = nil 
      end 

      return result
    end
  end
end
