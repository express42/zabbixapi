require "zabbixapi/version"
require "zabbixapi/client"
require "zabbixapi/server"
require "zabbixapi/applications"
require "zabbixapi/templates"
require "zabbixapi/hostgroups"
require "zabbixapi/users"
require "zabbixapi/hosts"
require "zabbixapi/triggers"
require "zabbixapi/items"
require "zabbixapi/graphs"

class ZabbixApi

  attr :client
  attr :server
  attr :users
  attr :items
  attr :applications
  attr :templates
  attr :hostgroups
  attr :hosts
  attr :triggers
  attr :graphs

  def self.connect(options = {})
    new(options)
  end

  def self.current
    @current ||= ZabbixApi.new
  end

  def initialize(options = {})
    @client = Client.new(options)
    @server = Server.new(options)
    @users   = Users.new(options)
    @items   = Items.new(options)
    @hosts   = Hosts.new(options)
    @applications = Applications.new(options)
    @templates    = Templates.new(options)
    @hostgroups   = HostGroups.new(options)
    @triggers = Triggers.new(options)
    @graphs = Graphs.new(options)
  end

end