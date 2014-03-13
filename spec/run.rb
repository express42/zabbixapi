#encoding: utf-8

describe ZabbixApi do

  it "TRIGGER: Create" do
    triggerid = zbx.triggers.create(
      :description => trigger,
      :expression => "{#{template}:proc.num[aaa].last(0)}<1",
      :comments => "Bla-bla is faulty (disaster)",
      :priority => 5,
      :status     => 0,
      :templateid => 0,
      :type => 0
    )
    triggerid.should be_kind_of(Integer)
  end

  it "TRIGGER: Find" do
    zbx.triggers.get_id(:description => trigger).should eq triggerid + 1 # вау блять
  end

  it "GRAPH: Create" do 
    gitems = {
        :itemid => zbx.items.get_id(:description => item), 
        :calc_fnc => "2",
        :type => "0",
        :periods_cnt => "5"
    }
    graphid = zbx.graphs.create(
      :gitems => [gitems],
      :show_triggers => "0",
      :name => graph,
      :width => "900",
      :height => "200"
    )
    graphid.should be_kind_of(Integer)
  end

  it "GRAPH: Create or get" do 
    gitems = {
        :itemid => zbx.items.get_id(:description => item), 
        :calc_fnc => "2",
        :type => "0",
        :periods_cnt => "5"
    }
    zbx.graphs.get_or_create(
      :gitems => [gitems],
      :show_triggers => "0",
      :name => graph,
      :width => "900",
      :height => "200"
    ).should eq graphid
  end

  it "GRAPH: Find gititems" do
    zbx.graphs.get_items( zbx.graphs.get_id(:name => graph) )
  end

  it "GRAPH: Find" do
    zbx.graphs.get_id( :name => graph ).should eq graphid
  end

  it "GRAPH: get_ids_by_host" do
    graph_array = zbx.graphs.get_ids_by_host( :host => host )
    graph_array.should be_kind_of(Array)
    graph_array.should include(graphid.to_s)
  end

  it "GRAPH: Update" do
    zbx.graphs.update(
      :graphid => zbx.graphs.get_id(
        :name => graph,
        :hostid => zbx.hosts.get_id(:host => host)
      ), 
      :ymax_type => 1
    ).should eq graphid
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
  ).should eq graphid
  end

  it "SCREEN: Get or create for host" do
    screenid = zbx.screens.get_or_create_for_host(
      :screen_name => screen_name,
      :graphids => zbx.graphs.get_ids_by_host(:host => host)
    )
    screenid.should be_kind_of(Integer)
  end

  it "TEMPLATE: Unlink hosts from templates" do
    zbx.templates.mass_remove(
      :hosts_id => [zbx.hosts.get_id(:host => host)],
      :templates_id => [zbx.templates.get_id(:host => template)]
    ).should be_kind_of(TrueClass)
  end

  it "SCREEN: Delete" do
    zbx.screens.delete(:screen_id => screenid).should eq screenid
  end

  it "GRAPH: Delete" do
    zbx.graphs.delete(zbx.graphs.get_id(:name => graph)).should be_kind_of(TrueClass)
  end

  it "TRIGGER: Delete" do
    zbx.triggers.delete( zbx.triggers.get_id(:description => trigger) ).should eq triggerid + 1 
  end

  it "HOST: Delete" do
    zbx.hosts.delete( zbx.hosts.get_id(:host => host) ).should eq hostid
  end

  it "ITEM: Delete" do
    zbx.items.delete(
      zbx.items.get_id(:description => item)
    ).should eq itemid
  end

  it "APPLICATION: Delete" do
    zbx.applications.delete( zbx.applications.get_id(:name => application) ).should eq applicationid
  end

  it "TEMPLATE: Delete" do
    zbx.templates.delete(zbx.templates.get_id(:host => template)).should eq templateid
  end

  it "HOSTGROUP: Delete" do
    zbx.hostgroups.delete(
      zbx.hostgroups.get_id(:name => hostgroup)
    ).should eq hostgroupid
  end

  it "USERGROUPS: Create" do
    usergroupid = zbx.usergroups.create(:name => usergroup)
    usergroupid.should be_kind_of(Integer)
  end

  it "USERGROUPS: Create or update" do
    zbx.usergroups.get_or_create(:name => usergroup).should eq usergroupid
  end

  it "USERGROUPS: Add user" do
    zbx.usergroups.add_user(
        :usrgrpids => [zbx.usergroups.get_id(:name => usergroup)],
        :userids => [zbx.users.get_id(:name => user2)]
    ).should eq usergroupid
  end

  it "USERGROUPS: Set UserGroup read & write perm" do
    zbx.usergroups.set_perms(
      :usrgrpid => zbx.usergroups.get_or_create(:name => usergroup).to_s,
      :hostgroupids => zbx.hostgroups.all.values,
      :permission => 3
    ).should eq usergroupid
  end


  it "USER: Create" do
    userid = zbx.users.create(
      :alias => "Test #{user}",
      :name => user,
      :surname => user,
      :passwd => user,
      :usrgrps => [usergroupid]
    )
    userid.should be_kind_of(Integer)
  end

  it "USER: Create or update" do
    zbx.users.create_or_update(
      :alias => "Test #{user}",
      :name => user,
      :surname => user,
      :passwd => user
    ).should eq userid
  end

  it "USER: Find" do
    zbx.users.get_full_data(:name => user)[0]['name'].should be_kind_of(String)
  end

  it "USER: Update" do
    zbx.users.update(:userid => zbx.users.get_id(:name => user), :name => user2).should be_kind_of(Integer)
  end

  it "USER: Find unknown" do
    zbx.users.get_id(:name => "#{user}_____").should be_kind_of(NilClass)
  end

  it "MEDIATYPE: Create" do
    mediatypeid = zbx.mediatypes.create(
      :description => mediatype,
      :type => 0,
      :smtp_server => "127.0.0.1",
      :smtp_email => "zabbix@test.com"
    )
    mediatypeid.should be_kind_of(Integer)
  end

  it "MEDIATYPE: Update or create" do
    zbx.mediatypes.create_or_update(
      :description => mediatype,
      :smtp_email => "zabbix2@test.com"
    ).should eq mediatypeid
  end

  it "USER: Add mediatype" do
    zbx.users.add_medias(
      :userids => [zbx.users.get_id(:name => user2)],
      :media => [
        {
          :mediatypeid => zbx.mediatypes.get_id(:description => mediatype), 
          :sendto => "test@test", 
          :active => 0, 
          :period => "1-7,00:00-24:00",
          :severity => "56"
        }
      ]
    ).should eq userid
  end

  it "MEDIATYPE: Delete" do
    zbx.mediatypes.delete(
      zbx.mediatypes.get_id(:description => mediatype)
    ).should eq mediatypeid
  end

  it "USER: Delete" do
    zbx.users.delete(zbx.users.get_id(:name => user2)).should eq userid
  end

  it "USERGROUPS: Delete" do
    zbx.usergroups.delete([zbx.usergroups.get_id(:name => usergroup)]).should eq usergroupid
  end

  it "QUERY" do
    zbx.query(
      :method => "apiinfo.version", 
      :params => {}
    ).should be_kind_of(String)
  end

end
