require 'spec_helper'

describe 'ZabbixApi::Server' do
  let(:server_mock) { ZabbixApi::Server.new(client) }
  let(:client) { double }
  let(:result) { 'testresult' }

  before do
    allow(client).to receive(:api_request).with(
      method: 'apiinfo.version',
      params: {}
    ).and_return(result)
  end

  describe '.initialize' do
    subject { server_mock }

    it 'sets client class variable' do
      expect(subject.instance_variable_get(:@client)).to eq client
    end

    it 'sets api_version class variable' do
      expect(subject.instance_variable_get(:@api_version)).to eq result
    end
  end
end
