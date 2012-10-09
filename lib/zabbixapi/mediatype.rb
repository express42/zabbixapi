module Zabbix
  class ZabbixApi

    def get_mediatype_id(mediatype)
      message = {
        'method' => 'mediatype.get',
        'params' => {
        'search' => {
          'description' => mediatype
          },
        'output' => 'extend',
        }
      }
      response = send_request(message)
      response.empty? ?  nil : response[0]['mediatypeid'].to_i
    end

    def add_mediatype(mediatype_options)
      mediatype_default = {
        'type' => '0',
        'description' => '',
        'smtp_server' => '',
        'smtp_helo'   => '',
        'smtp_email'  => '',
        'exec_path'   => '',
        'gsm_modem'   => '',
        'username'    => '',
        'passwd'      => ''
      }
      mediatype = merge_opt(mediatype_default, mediatype_options)
      message = {
        'method' => 'mediatype.create',
        'params' => mediatype
      }
      response = send_request(message)
      response.empty? ? nil : response['mediatypeids'][0].to_i
    end

    def delete_mediatype(mediatype)
      if mediatype_id = get_mediatype_id(mediatype)
        message = {
            'method' => 'mediatype.delete',
            'params' => 
                [mediatype_id]
        }
        response = send_request(message)
        response.empty? ? nil : response['mediatypeids'][0]
      end
    end

  end
end

