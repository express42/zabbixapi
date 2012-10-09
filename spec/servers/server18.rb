class Server18

  def self.hostgroup_create
    # http://www.zabbix.com/documentation/1.8/api/hostgroup/create
    '
    {
      "jsonrpc":"2.0",
        "result":{
          "groupids": ["107819"]
        },
      "id":3
    }
    '
  end

  def self.hostgroup_get
    # http://www.zabbix.com/documentation/1.8/api/hostgroup/get
    '
    {
      "jsonrpc":"2.0",
      "result":[
          {
              "groupid":"100100000000002",
              "name":"Linux servers",
              "internal":"0"
          },
          {
              "groupid":"100100000000004",
              "name":"ZABBIX Servers",
              "internal":"0"
          }
      ],
      "id":2
      }
    '
  end

  def self.hostgroup_get_error
    # http://www.zabbix.com/documentation/1.8/api/hostgroup/get
    '
    {
      "jsonrpc":"2.0",
        "result":[
          ],
      "id":2
    }
    '
  end

  def self.host_create
    # http://www.zabbix.com/documentation/1.8/api/host/create
    '
    {
      "jsonrpc":"2.0",
      "result":{
         "hostids": ["107819"]
        },
      "id":3
    }
    '
  end

  def self.host_create_error
    # http://www.zabbix.com/documentation/1.8/api/host/create
    '
    {
      "jsonrpc":"2.0",
      "error":{
            "code":-32602,
            "message":"Invalid params.",
            "data":"[ CHost::create ] Host [ Linux001 ] already exists"
          },
      "id":3
    }     
    '
  end

  def self.host_get
    # http://www.zabbix.com/documentation/1.8/api/host/get
    '
    {
      "jsonrpc":"2.0",
      "result":[{
          "maintenances":[{
              "maintenanceid":"0"
          }],
          "hostid":"100100000010017",
          "proxy_hostid":"0",
          "host":"ZABBIX-Server",
          "dns":"ip4-dm",
          "useip":"1",
          "ip":"192.168.3.4",
          "port":"31055",
          "status":"0",
          "disable_until":"0",
          "error":"",
          "available":"1",
          "errors_from":"0",
          "lastaccess":"0",
          "inbytes":"0",
          "outbytes":"0",
          "useipmi":"0",
          "ipmi_port":"623",
          "ipmi_authtype":"-1",
          "ipmi_privilege":"2",
          "ipmi_username":"",
          "ipmi_password":"",
          "ipmi_disable_until":"0",
          "ipmi_available":"0",
          "snmp_disable_until":"0",
          "snmp_available":"0",
          "maintenanceid":"0",
          "maintenance_status":"0",
          "maintenance_type":"0",
          "maintenance_from":"0",
          "ipmi_ip":"",
          "ipmi_errors_from":"0",
          "snmp_errors_from":"0",
          "ipmi_error":"",
          "snmp_error":""
      },{
          "maintenances":[{
              "maintenanceid":"0"
          }],
          "hostid":"100100000010229",
          "proxy_hostid":"0",
          "host":"ZABBIX-Server TEST",
          "dns":"ip4-dm",
          "useip":"1",
          "ip":"192.168.3.4",
          "port":"31055",
          "status":"0",
          "disable_until":"0",
          "error":"",
          "available":"1",
          "errors_from":"0",
          "lastaccess":"0",
          "inbytes":"0",
          "outbytes":"0",
          "useipmi":"0",
          "ipmi_port":"623",
          "ipmi_authtype":"-1",
          "ipmi_privilege":"2",
          "ipmi_username":"",
          "ipmi_password":"",
          "ipmi_disable_until":"0",
          "ipmi_available":"0",
          "snmp_disable_until":"0",
          "snmp_available":"0",
          "maintenanceid":"0",
          "maintenance_status":"0",
          "maintenance_type":"0",
          "maintenance_from":"0",
          "ipmi_ip":"",
          "ipmi_errors_from":"0",
          "snmp_errors_from":"0",
          "ipmi_error":"",
          "snmp_error":""
      }],
      "id":2
      }
    '
  end

  def self.host_get_error
    # http://www.zabbix.com/documentation/1.8/api/host/get
   '
    {
      "jsonrpc":"2.0",
        "result":[
          ],
      "id":2
    }
   ' 
  end

  def self.host_delete
    # http://www.zabbix.com/documentation/1.8/api/host/delete 
    '
    {
      "jsonrpc":"2.0",
      "result":{
         "hostids": ["107824", "107825"]
      },
      "id":2
      }
    '
  end

  def self.mediatype_create
    # http://www.zabbix.com/documentation/1.8/api/mediatype/create
    '
    {
      "jsonrpc": "2.0",
      "result": {
         "mediatypeids": ["100100000214797"]
      },
      "id": 2
    }    
    '
  end

  def self.mediatype_create_error
    # http://www.zabbix.com/documentation/1.8/api/mediatype/create
    '
    {
      "jsonrpc": "2.0",
      "error": {
            "code": -32602,
            "message": "Invalid params.",
            "data": "[ CMediatype::create ] Cannot create Mediatype"
      },
      "id": 2
    }
    '
  end

  def self.mediatype_delete
    # http://www.zabbix.com/documentation/1.8/api/mediatype/delete
    '
    {
      "jsonrpc": "2.0",
      "result": {
         "mediatypeids": ["107824", "107825"]
      },
      "id": 2
    }
    '
  end

  def self.mediatype_delete_error
    # http://www.zabbix.com/documentation/1.8/api/mediatype/delete
    '
    {
      "jsonrpc": "2.0",
      "error": {
            "code": -32500,
            "message": "Application error.",
            "data": "[ CMediatype::delete ] Mediatype does not exist"
      },
      "id": 2
    }    
    '
  end
end
