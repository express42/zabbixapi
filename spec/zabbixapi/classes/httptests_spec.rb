require 'spec_helper'

describe 'ZabbixApi::HttpTests' do
  let(:httptests_mock) { ZabbixApi::HttpTests.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { httptests_mock.method_name }

    it { is_expected.to eq 'httptest' }
  end

  describe '.identify' do
    subject { httptests_mock.identify }

    it { is_expected.to eq 'name' }
  end

  describe '.default_options' do
    subject { httptests_mock.default_options }

    let(:result) do
      {
        hostid: nil,
        name: nil,
        steps: []
      }
    end

    it { is_expected.to eq result }
  end

  describe '.get_or_create' do
    subject { httptests_mock.get_or_create(data) }

    let(:data) { { name: 'batman', hostid: 1234 } }
    let(:result) { [{ 'testkey' => '111', 'testidentify' => 1 }] }
    let(:id) { nil }
    let(:id_through_create) { 222 }

    before do
      allow(httptests_mock).to receive(:log)
      allow(httptests_mock).to receive(:get_id).with(name: data[:name], hostid: data[:hostid]).and_return(id)
      allow(httptests_mock).to receive(:create).with(data).and_return(id_through_create)
    end

    it 'logs the debug message' do
      expect(httptests_mock).to receive(:log).with("[DEBUG] Call get_or_create with parameters: #{data.inspect}")
      subject
    end

    context 'when ID already exist' do
      let(:id) { '111' }

      it 'returns the existing ID' do
        expect(subject).to eq id
      end
    end

    context 'when id does not exist' do
      it 'returns the newly created ID' do
        expect(subject).to eq id_through_create
      end
    end
  end

  describe '.create_or_update' do
    subject { httptests_mock.create_or_update(data) }

    let(:data) { { name: 'batman', hostid: 111 } }
    let(:result) { [{ 'testkey' => '111', 'testidentify' => 1 }] }
    let(:key) { 'testkey' }
    let(:identify) { 'testidentify' }
    let(:httptestid) { nil }
    let(:id_through_create) { 222 }
    let(:update_data) { { name: data[:name], hostid: data[:hostid], httptestid: httptestid } }

    before do
      allow(httptests_mock).to receive(:log)
      allow(httptests_mock).to receive(:identify).and_return(identify)
      allow(httptests_mock).to receive(:get_id)
        .with(name: data[:name], hostid: data[:hostid]).and_return(httptestid)
      allow(httptests_mock).to receive(:create).with(data).and_return(id_through_create)
      allow(httptests_mock).to receive(:update).with(update_data).and_return(httptestid)
    end

    context 'when Host ID already exist' do
      let(:httptestid) { 1234 }

      it 'updates an object returns the Host ID' do
        expect(subject).to eq httptestid
      end
    end

    context 'when Host ID does not exist' do
      it 'creates an object returns the newly created object ID' do
        expect(subject).to eq id_through_create
      end
    end
  end
end
