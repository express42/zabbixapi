#encoding: utf-8

require 'spec_helper'

describe 'host' do
  before :all do
    @hostgroup = gen_name 'hostgroup'
    @hostgroup3 = gen_name 'hostgroup'
    @hostgroupid = zbx.hostgroups.create(:name => @hostgroup)
    @hostgroupid3 = zbx.hostgroups.create(:name => @hostgroup3)
  end

  context 'when name not exists' do
    before do
      @host = gen_name 'host'
    end

    describe 'create' do
      it "should return integer id" do
        hostid = zbx.hosts.create(
          :host => @host,
          :interfaces => [
            {
              :type => 1,
              :main => 1,
              :ip => "10.20.48.88",
              :dns => "",
              :port => 10050,
              :useip => 1
            }
          ],
          :groups => [:groupid => @hostgroupid]
        )
        hostid.should be_kind_of(Integer)
      end

      it "should create host in multiple groups" do
        @hostgroupid2 = zbx.hostgroups.create(:name => gen_name('hostgroup'))
        host = gen_name('host')
        hostid = zbx.hosts.create(
          :host => host,
          :interfaces => [{ :type => 1, :main => 1, :ip => '192.168.0.1', :dns => 'server.example.org', :port => 10050, :useip => 0 }],
          :groups => [
            {:groupid => @hostgroupid},
            {:groupid => @hostgroupid2}
          ])

        expect(hostid).to be_kind_of Integer
        host = zbx.query(:method => 'host.get', :params => { :hostids => [hostid], :selectGroups => 'extend' }).first

        expect(host['hostid'].to_i).to eq hostid
        expect(host['groups'].size).to eq 2
      end
    end

    describe 'get_id' do
      it "should return nil" do
        expect(zbx.hosts.get_id(:host => @host)).to be_kind_of(NilClass)
      end
    end
  end

  context 'when name exists' do
    before :all do
      @host = gen_name 'host'
      @hostid = zbx.hosts.create(
        :host => @host,
        :interfaces => [
          {
            :type => 1,
            :main => 1,
            :ip => "10.20.48.88",
            :dns => "",
            :port => 10050,
            :useip => 1
          }
        ],
        :groups => [:groupid => @hostgroupid]
      )
    end

    describe 'get_or_create' do
      it "should return id of host" do
        expect(zbx.hosts.get_or_create(
          :host => @host,
          :groups => [:groupid => @hostgroupid]
        )).to eq @hostid
      end
    end

    describe 'get_full_data' do
      it "should contains created host" do
        expect(zbx.hosts.get_full_data(:host => @host)[0]).to include("host" => @host)
      end

      it "shoulld dump interfaces" do
        expect(zbx.hosts.get_full_data(:host => @host, :params => {:selectInterfaces => "extend"})[0]["interfaces"][0]).to include("type" => "1")
        expect(zbx.hosts.get_full_data(:host => @host, :params => {:selectInterfaces => "extend"})[0]["interfaces"][0]).to include("ip" => "10.20.48.88")
      end
    end

    describe 'get_id' do
      it "should return id of host" do
        expect(zbx.hosts.get_id(:host => @host)).to eq @hostid
      end
    end

    describe 'create_or_update' do
      it "should return id of updated host" do
        zbx.hosts.create_or_update(
          :host => @host,
          :interfaces => [
            {
              :type => 1,
              :main => 1,
              :ip => "10.20.48.89",
              :port => 10050,
              :useip => 1,
              :dns => ''
            }
          ],
          :groups => [:groupid => @hostgroupid]
        ).should eq @hostid
      end

      it "should add ghostgroup" do
        zbx.hosts.create_or_update( {
            :host => @host,
            :interfaces => [
                {
                    :type => 1,
                    :main => 1,
                    :ip => "10.20.48.89",
                    :port => 10050,
                    :useip => 1,
                    :dns => ''
                }
            ],
            :groups => [{:groupid => @hostgroupid},
                        {:groupid => @hostgroupid3}]
                                    }, true)
        zbx.hosts.get_full_data(
            :host => @host,
            :params => {
                :selectGroups => "extend"
            }
        )[0]["groups"].collect { |group| group["groupid"].to_s }.sort.should eq [@hostgroupid, @hostgroupid3].collect{|item| item.to_s}.sort
      end
    end

    describe 'update' do
      it "should return id" do
        zbx.hosts.update(
          :hostid => @hostid,
          :status => 0
        ).should eq @hostid
      end
    end

    describe 'delete' do
      it "HOST: Delete" do
        zbx.hosts.delete( @hostid ).should eq @hostid
      end
    end
  end
end

