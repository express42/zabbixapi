#!/usr/bin/ruby

require 'json'
require 'net/http'
require 'net/https'

module Zabbix

  class SocketError < RuntimeError
  end

  class ResponseCodeError < RuntimeError
  end

  class ResponseError < RuntimeError
  end

  class AlreadyExist < RuntimeError
  end

  class ZabbixApi

    attr_accessor :debug

    def initialize ( api_url, api_user, api_password )
      @api_url = api_url
      @api_user = api_user
      @api_password = api_password

      @debug = false # Disable debug by default
    end

    def do_request(message)

      id = rand 100_000

      message['id'] = id
      message['jsonrpc'] = '2.0'

      message_json = JSON.generate(message)

      uri = URI.parse(@api_url)
      http = Net::HTTP.new(uri.host, uri.port)

      if ( uri.scheme == "https" ) then
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      request = Net::HTTP::Post.new(uri.request_uri)
      request.add_field('Content-Type', 'application/json-rpc')
      request.body=(message_json)

      begin
        puts "[ZBXAPI] : INFO : Do request. Body => #{request.body}" if @debug
        response = http.request(request)
      rescue ::SocketError => e
        puts "[ZBXAPI] : ERROR : SocketError => #{e.message}" if @debug
        raise Zabbix::SocketError.new(e.message)
      end

      if @debug
        puts "[ZBXAPI] : INFO : Response start"
        puts response
        puts "[ZBXAPI] : INFO : Response end"
      end

      if response.code != "200"
        raise Zabbix::ResponseCodeError.new("Responce code from [" + @api_url + "] is #{response.code}")
      end

      response_body_hash = JSON.parse(response.body)

      if error = response_body_hash['error']
        error_message = error['message']
        error_data = error['data']
        error_code = error['code']

        e_message = "Code: [" + error_code.to_s + "]. Message: [" + error_message +\
              "]. Data: [" + error_data + "]."

        case error_code.to_s 
        when '-32602'
          raise Zabbix::AlreadyExist.new(e_message)
        else
          raise Zabbix::ResponseError.new(e_message)
        end
      end

      result = response_body_hash['result']

      return result
    end

    def send_request(message)
      message['auth'] = auth()
      do_request(message)
    end

    def auth()

      auth_message = {
        'auth' =>  nil,
        'method' =>  'user.authenticate',
        'params' =>  {
          'user' => @api_user,
          'password' => @api_password,
          '0' => '0'
        }
      }

      auth_id = do_request(auth_message)

      return auth_id
    end

# Utils. 
    def merge_opt(a, b)
      c = {}

      b.each_pair do |key, value|
        if a.has_key?(key) then
          c[key] = value
        end
     end

      return a.merge(c)
    end
  end
end
