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
      responce.empty? ? nil : responce['applicationids'][0].to_i
    end
  end

  def get_app_id(host_id, app_name)
    message = {
        'method' => 'application.get',
        'params' => {
            'filter' => {
                'name' => app_name,
                'hostid' => host_id
            }
        }
    }
    responce = send_request(message)
    responce.empty? ? nil : responce[0]['applicationid']
  end

end
