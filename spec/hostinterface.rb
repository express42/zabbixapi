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
              }
          ],
          :groups => [:groupid => @hostgroupid]
      )
      @interfaceid = zbx.hostinterfaces.create(:hostid => @hostid, :type => 1, :main => 0, :ip => "10.20.48.88", :dns => "", :port => 10050, :useip => 1)
    end

    describe 'get_full_data' do
      it "should contains created host" do
        expect(zbx.hostinterfaces.get_full_data(:hostid => "#{@hostid}")[0]).to include("hostid" => "#{@hostid}")
      end
    end

  end
end