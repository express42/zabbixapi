#encoding: utf-8

require 'spec_helper'

describe "hostinterface" do
  before :all do
    @hostgroup = gen_name 'hostgroup'
    @hostgroupid = zbx.hostgroups.create(:name => @hostgroup)
  end

  context 'when interface not exists' do
    before do
      @host = gen_name 'host'
    end

    describe 'create' do
      it 'should return integer id' do
        @hostid = zbx.hosts.create(:host => @host,
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
        interfaceid = zbx.hostinterfaces.create(
            :hostid => @hostid,
            :dns => "",
            :ip => "1.1.1.1",
            :main => 0,
            :port => '10050',
            :type => 1,
            :useip => 1
        )
        interfaceid.should be_kind_of(Integer)
      end

      describe 'get_id' do
        it "should return nil" do
          random_id = gen_name('')
          expect(zbx.hosts.get_id(:hostids => [random_id])).to be_kind_of(NilClass)
        end
      end
    end
  end

  context 'when interface exists' do
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
              },
          ],
          :groups => [:groupid => @hostgroupid]
      )
      @interfaceid1 = zbx.hostinterfaces.create(:hostid => @hostid, :type => 1, :main => 0, :ip => "10.20.48.88", :dns => "", :port => 10050, :useip => 1)
      @interfaceid2 = zbx.hostinterfaces.create(:hostid => @hostid, :type => 1, :main => 0, :ip => "10.20.48.88", :dns => "", :port => 10050, :useip => 1)
    end

    describe 'get_full_data' do
      it "should contains created host" do
        expect(zbx.hostinterfaces.get_full_data(:params => {:filter =>  {:hostid => "#{@hostid}"}})[0]).to include("hostid" => "#{@hostid}")
      end
    end

    describe 'get_id' do
      it "should update existing interface" do
        zbx.hostinterfaces.create_or_update(:interfaceid => @interfaceid1, :type => 2, :ip => "8.8.8.8")
        dump = zbx.hostinterfaces.get_full_data(:interfaceid => @interfaceid1)
        dump[0]["type"].to_s.should eq 2.to_s
        dump[0]["ip"].to_s.should eq "8.8.8.8"
      end
    end
  end
end