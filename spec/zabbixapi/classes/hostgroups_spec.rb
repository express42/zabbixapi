require 'spec_helper'

describe 'ZabbixApi::HostGroups' do
  let(:actions_mock) { ZabbixApi::HostGroups.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { actions_mock.method_name }

    it { is_expected.to eq 'hostgroup' }
  end

  describe '.indentify' do
    subject { actions_mock.indentify }

    it { is_expected.to eq 'name' }
  end

  describe '.key' do
    subject { actions_mock.key }

    it { is_expected.to eq 'groupid' }
  end
end
