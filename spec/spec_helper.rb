require 'zabbixapi'

def zbx
  # settings
  @api_url = ENV['ZABBIX_HOST_URL'] || 'http://localhost:8080/api_jsonrpc.php'
  @api_login = ENV['ZABBIX_USERNAME'] || 'Admin'
  @api_password = ENV['ZABBIX_PASSWORD'] || 'zabbix'

  @zbx ||= ZabbixApi.connect(
    url: @api_url,
    user: @api_login,
    password: @api_password,
    debug: ENV['ZABBIX_DEBUG'] ? true : false
  )
end

def gen_name(prefix)
  suffix = rand(1_000_000_000)
  "#{prefix}_#{suffix}"
end

IRB ||= false

if IRB
  media_type_data = {
    "name"=>"zz",
    "type"=>2,
    "server"=>nil,
    "helo"=>nil,
    "email"=>nil,
    "path"=>nil,
    "gsm_modem"=>"/dev/modemzzz",
    "username"=>nil,
    "password"=>nil
  }.transform_keys(&:to_sym)

  zbx.mediatypes.create_or_update(media_type_data)

  zbx.mediatypes.dump_by_id(mediatypeid: 28)

  zbx.mediatypes.get_id({name: "sms"})
end

