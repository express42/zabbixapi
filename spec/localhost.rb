require 'zabbixapi'

# settings
#api_url = 'http://zabbix/zabbix12/api_jsonrpc.php'
api_url = 'http://zabbix/zabbix13/api_jsonrpc.php'
#api_url = 'http://zabbix/zabbix20/api_jsonrpc.php'

api_login = 'Admin'
api_password = 'zabbix'

zbx = ZabbixApi.connect(
  :url => api_url,
  :user => api_login,
  :password => api_password,
  :debug => false
)

hostgroup = "hostgroup______1"
template  = "template______1"
application = "application_____1"
item = "item_____1"
host = "hostname____1"
trigger = "trigger____1"
user = "user____1"
user2 = "user____2"
graph = "graph___a"

puts "### Zabbix API server version #{zbx.server.version} ###"

describe ZabbixApi, "test_api" do

  it "SERVER: Get version api" do
    zbx.server.version.should be_kind_of(String)
  end

  it "HOSTGROUP: Create" do
    zbx.hostgroups.create(:name => hostgroup).should be_kind_of(Integer)
  end

  it "HOSTGROUP: Find" do
    zbx.hostgroups.get_id(:name => hostgroup).should be_kind_of(Integer)
  end

  it "HOSTGROUP: Find unknown" do
    zbx.hostgroups.get_id(:name => "#{hostgroup}______").should be_kind_of(NilClass)
  end

  it "HOSTGROUP: Create or update" do
    zbx.hostgroups.create_or_update(:name => hostgroup).should be_kind_of(Integer)
  end

  it "TEMPLATE: Create" do
    zbx.templates.create(
      :host => template,
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    ).should be_kind_of(Integer)
  end

  it "TEMPLATE: Get get or create" do
    zbx.templates.get_or_create(
      :host => template,
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    ).should be_kind_of(Integer)
  end

  it "TEMPLATE: Check full data" do
    zbx.templates.get_full_data(:host => template)[0]['host'].should be_kind_of(String)
  end

  it "TEMPLATE: Find" do
    zbx.templates.get_id(:host => template).should be_kind_of(Integer)
  end

  it "TEMPLATE: Find unknown" do
    zbx.templates.get_id(:host => "#{template}_____").should be_kind_of(NilClass)
  end

  it "APPLICATION: Create" do
    zbx.applications.create(
      :name => application,
      :hostid => zbx.templates.get_id(:host => template)
    )
  end

  it "APPLICATION: Get or create" do
    zbx.applications.get_or_create(
      :name => application,
      :hostid => zbx.templates.get_id(:host => template)
    )
  end

  it "APPLICATION: Full info check" do
    zbx.applications.get_full_data(:name => application)[0]['applicationid'].should be_kind_of(String)
  end

  it "APPLICATION: Find" do
    zbx.applications.get_id(:name => application).should be_kind_of(Integer)
  end

  it "APPLICATION: Find unknown" do
    zbx.applications.get_id(:name => "#{application}___").should be_kind_of(NilClass)
  end

  it "ITEM: Create" do
    zbx.items.create(
      :description => item,
      :key_ => "proc.num[aaa]",
      :hostid => zbx.templates.get_id(:host => template),
      :applications => [zbx.applications.get_id(:name => application)]
    ).should be_kind_of(Integer)
  end

  it "ITEM: Full info check" do
    zbx.items.get_full_data(:description => item)[0]['itemid'].should be_kind_of(String)
  end

  it "ITEM: Find" do
    zbx.items.get_id(:description => item).should be_kind_of(Integer)
  end

  it "ITEM: Update" do
    zbx.items.update(
      :itemid => zbx.items.get_id(:description => item),
      :status => 0
    ).should be_kind_of(Integer)
  end

  it "ITEM: Create or update" do
    zbx.items.create_or_update(
      :description => item,
      :key_ => "proc.num[aaa]",
      :type => 6,
      :hostid => zbx.templates.get_id(:host => template),
      :applications => [zbx.applications.get_id(:name => application)]
    ).should be_kind_of(Integer)
  end

  it "ITEM: Get unknown" do
    zbx.items.get_id(:description => "#{item}_____")
  end

  it "HOST: Create" do
    zbx.hosts.create(
      :host => host,
      :ip => "10.20.48.88",
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    ).should be_kind_of(Integer)
  end

  it "HOST: Update or create" do
    zbx.hosts.create_or_update(
      :host => host,
      :ip => "10.20.48.89",
      :groups => [:groupid => zbx.hostgroups.get_id(:name => hostgroup)]
    ).should be_kind_of(Integer)
  end

  it "HOST: Find unknown" do
    zbx.hosts.get_id(:host => "#{host}___").should be_kind_of(NilClass)
  end

  it "HOST: Find" do
    zbx.hosts.get_id(:host => host).should be_kind_of(Integer)
  end

  it "HOST: Update" do
    zbx.hosts.update(
      :hostid => zbx.hosts.get_id(:host => host),
      :status => 0
    )
  end

  it "TEMPLATE: Get all templates linked with host" do
    zbx.templates.get_ids_by_host(
      :hostids => [zbx.hosts.get_id(:host => host)]
    ).should be_kind_of(Array)
  end

  it "TEMPLATE: Linked hosts with templates" do
    zbx.templates.mass_add(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "TEMPLATE: Update hosts with templates" do
    zbx.templates.mass_update(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "TEMPLATE: Unlink hosts from templates" do
    zbx.templates.mass_remove(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "TEMPLATE: Get all" do 
    zbx.templates.all.should be_kind_of(Hash)
  end

  it "TRIGGER: Create" do
    zbx.triggers.create(
      :description => trigger,
      :expression => "{#{template}:proc.num[aaa].last(0)}<1",
      :comments => "Bla-bla is faulty (disaster)",
      :priority => 5,
      :status     => 0,
      :templateid => 0,
      :type => 0
    ).should be_kind_of(Integer)
  end

  it "TRIGGER: Find" do
    zbx.triggers.get_id(:description => trigger).should be_kind_of(Integer)
  end

  it "GRAPH: Create" do 
    gitems = {
        :itemid => zbx.items.get_id(:description => item), 
        :calc_fnc => "2",
        :type => "0",
        :periods_cnt => "5"
    }
    zbx.graphs.create(
      :gitems => [gitems],
      :show_triggers => "0",
      :name => graph,
      :width => "900",
      :height => "200"
    ).should be_kind_of(Integer)
  end

  it "GRAPH: Find gititems" do
    zbx.graphs.get_items( zbx.graphs.get_id(:name => graph) )
  end

  it "GRAPH: Find" do
    zbx.graphs.get_id( :name => graph ).should be_kind_of(Integer)
  end

  it "GRAPH: Update" do
    zbx.graphs.update(
      :graphid => zbx.graphs.get_id(
        :name => graph,
        :hostid => zbx.hosts.get_id(:host => host)
      ), 
      :ymax_type => 1
    ).should be_kind_of(Integer)
  end

  it "GRAPH: Create or Update" do
    gitems = {
      :itemid => zbx.items.get_id(:description => item), 
      :calc_fnc => "3",
      :type => "0",
      :periods_cnt => "5"
    }
  zbx.graphs.create_or_update(
    :gitems => [gitems],
    :show_triggers => "1",
    :name => graph,
    :width => "900",
    :height => "200"
  ).should be_kind_of(Integer)
  end

  it "GRAPH: Delete" do
    zbx.graphs.delete(zbx.graphs.get_id(:name => graph)).should be_kind_of(Integer)
  end

  it "TRIGGER: Delete" do
    zbx.triggers.delete( zbx.triggers.get_id(:description => trigger) ).should be_kind_of(Integer)
  end

  it "HOST: Delete" do
    zbx.hosts.delete( zbx.hosts.get_id(:host => host) ).should be_kind_of(Integer)
  end

  it "ITEM: Delete" do
    zbx.items.delete(
      zbx.items.get_id(:description => item)
    ).should be_kind_of(Integer)
  end

  it "APPLICATION: Delete" do
    zbx.applications.delete( zbx.applications.get_id(:name => application) )
  end

  it "TEMPLATE: Delete" do
    zbx.templates.delete(zbx.templates.get_id(:host => template))
  end

  it "HOSTGROUP: Delete" do
    zbx.hostgroups.delete(
      zbx.hostgroups.get_id(:name => hostgroup)
    ).should be_kind_of(Integer)
  end

  it "USER: Create" do
    zbx.users.create(
      :alias => "Test #{user}",
      :name => user,
      :surname => user,
      :passwd => user
    ).should be_kind_of(Integer)
  end

  it "USER: Find" do
    zbx.users.get_full_data(:name => user)[0]['name'].should be_kind_of(String)
  end

  it "USER: Update" do
    zbx.users.update(:userid => zbx.users.get_id(:name => user), :name => user2).should be_kind_of(Integer)
  end

  it "USER: Find unknown" do
    zbx.users.get_id(:name => "#{user}_____")
  end

  it "USER: Delete" do
    zbx.users.delete(zbx.users.get_id(:name => user2)).should be_kind_of(Integer)
  end

  it "QUERY" do
    zbx.query(
      :method => "apiinfo.version", 
      :params => {}
    ).should be_kind_of(String)
  end

end
