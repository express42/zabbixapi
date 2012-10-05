module Zabbix

  class ZabbixApi
    def add_macro(host_id, macro_name, macro_value)

      message = {
          'method' => 'Usermacro.create',
          'params' => {
              'hostid' => host_id,
              'macro' => macro_name,
              'value' => macro_value
          }
      }

      response = send_request(message)

      if hostmacroids == response['hostmacroids'] then
        result = hostmacroids
      else
        result = nil
      end

      return result
    end

    def get_macro(host_id, macro_name)

      message = {
          'method' => 'Usermacro.get',
          'params' => {
              'hostids' => host_id,
              'macros' => macro_name,
              'extendoutput' => '1'
          }
      }

      response = send_request(message)

      if response.empty?
        result = nil
      else
        if hostmacroid == response[0]['hostmacroid']
          macro_id = hostmacroid
          macro_value = response[0]['value']

          result = {
              'id' => macro_id,
              'value' => macro_value
          }
        else
          result = nil
        end
      end

      return result
    end

    def set_macro_value(host_id, macro_name, macro_value)

      message = {
          'method' => 'usermacro.updateValue',
          'params' => {
              'hostid' => host_id,
              'macro' => macro_name,
              'value' => macro_value
          }
      }

      response = send_request(message)

      return true
    end
  end
end
