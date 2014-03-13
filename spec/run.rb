#encoding: utf-8

describe ZabbixApi do


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

  it "TEMPLATE: Delete" do
    zbx.templates.delete(zbx.templates.get_id(:host => template)).should eq templateid
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

end
