require "zabbixapi/version"
require "zabbixapi/client"


class ZabbixApi

  attr :client

  def self.connect(options = {})
    new(options)
  end

  def self.current
    @current ||= ZabbixApi.new
  end

  def query(data)
    @client.api_request(:method => data[:method], :params => data[:params])
  end

  def initialize(options = {})
    @client = Client.new(options)
    if @client.api_version == "1.4" || @client.api_version =~ /2\.0\.\d+/
      apidir = "2.0"
    else
      raise "Zabbix API version: #{@client.api_version} is not support by this version of zabbixapi"
    end
    Dir["#{File.dirname(__FILE__)}/zabbixapi/#{apidir}/basic/*.rb"].each { |f| load(f) }
    Dir["#{File.dirname(__FILE__)}/zabbixapi/#{apidir}/classes/*.rb"].each { |f| load(f) }
  end

  def server
    @server ||= Server.new(@client)
  end

  def users
    @users ||= Users.new(@client)
  end

  def items
    @items ||= Items.new(@client)
  end

  def hosts
    @hosts ||= Hosts.new(@client)
  end

  def applications
    @applications ||= Applications.new(@client)
  end

  def templates
    @templates ||= Templates.new(@client)
  end

  def hostgroups
    @hostgroups ||= HostGroups.new(@client)
  end

  def triggers
    @triggers ||= Triggers.new(@client)
  end

  def graphs
    @graphs ||= Graphs.new(@client)
  end

  def proxies
    @proxies ||= Proxies.new(@client)
  end

  def screens
    @screens ||= Screens.new(@client)
  end  

  def usergroups
    @usergroups ||= Usergroups.new(@client)
  end

  def usermacros
    @usermacros ||= Usermacros.new(@client)
  end

  def mediatypes
    @mediatypes ||= Mediatypes.new(@client)
  end

end

