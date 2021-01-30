require 'spec_helper'

describe 'ZabbixApi::Triggers' do
  let(:unusable_mock) { ZabbixApi::Triggers.new(client) }

  let(:client) { double }

  describe '.create_or_update' do
    subject { unusable_mock.create_or_update(data) }

    let(:data) { { description: 'testdesc', hostid: 'hostid' } }

    before do
      allow(unusable_mock).to receive(:log)
      allow(unusable_mock).to receive(:get_or_create)
    end

    it 'logs debug message' do
      expect(unusable_mock).to receive(:log).with("[DEBUG] Call create_or_update with parameters: #{data.inspect}")
    end

    it 'calls get_or_create' do
      expect(unusable_mock).to receive(:get_or_create).with(data)
    end

    after { subject }
  end
end
