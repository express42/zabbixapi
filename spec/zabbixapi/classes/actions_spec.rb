require 'spec_helper'

describe 'ZabbixApi::Actions' do
  let(:actions_mock) { ZabbixApi::Actions.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { actions_mock.method_name }

    it { is_expected.to eq 'action' }
  end

  describe '.identify' do
    subject { actions_mock.identify }

    it { is_expected.to eq 'name' }
  end
end
