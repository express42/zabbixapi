require 'spec_helper'

describe 'ZabbixApi::Maintenance' do
  let(:maintenance_mock) { ZabbixApi::Maintenance.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { maintenance_mock.method_name }

    it { is_expected.to eq 'maintenance' }
  end

  describe '.indentify' do
    subject { maintenance_mock.indentify }

    it { is_expected.to eq 'name' }
  end
end
