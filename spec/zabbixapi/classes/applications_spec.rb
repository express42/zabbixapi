require 'spec_helper'

describe 'ZabbixApi::Applications' do
  let(:actions_mock) { ZabbixApi::Applications.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { actions_mock.method_name }

    it { is_expected.to eq 'application' }
  end

  describe '.identify' do
    subject { actions_mock.identify }

    it { is_expected.to eq 'name' }
  end

  describe '.get_or_create' do
    subject { actions_mock.get_or_create(data) }

    let(:data) { { name: 'batman', hostid: 1234 } }
    let(:result) { [{ 'testkey' => '111', 'testidentify' => 1 }] }
    let(:key) { 'testkey' }
    let(:identify) { 'testidentify' }
    let(:id) { nil }
    let(:id_through_create) { 222 }

    before do
      allow(actions_mock).to receive(:log)
      allow(actions_mock).to receive(:identify).and_return(identify)
      allow(actions_mock).to receive(:get_id).with(name: data[:name], hostid: data[:hostid]).and_return(id)
      allow(actions_mock).to receive(:create).with(data).and_return(id_through_create)
    end

    it 'logs the debug message' do
      expect(actions_mock).to receive(:log).with("[DEBUG] Call get_or_create with parameters: #{data.inspect}")
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
    subject { actions_mock.create_or_update(data) }

    let(:data) { { name: 'batman', hostid: 1234 } }
    let(:result) { [{ 'testkey' => '111', 'testidentify' => 1 }] }
    let(:key) { 'testkey' }
    let(:identify) { 'testidentify' }
    let(:id) { nil }
    let(:id_through_create) { 222 }
    let(:update_data) { { name: 'batman', hostid: 1234, applicationid: id } }

    before do
      allow(actions_mock).to receive(:log)
      allow(actions_mock).to receive(:identify).and_return(identify)
      allow(actions_mock).to receive(:get_id)
        .with(name: data[:name], hostid: data[:hostid]).and_return(id)
      allow(actions_mock).to receive(:create).with(data).and_return(id_through_create)
      allow(actions_mock).to receive(:update).with(update_data).and_return(id)
    end

    context 'when Application ID already exist' do
      let(:id) { '111' }

      it 'updates an object returns the object ID' do
        expect(subject).to eq id
      end
    end

    context 'when Application ID does not exist' do
      it 'creates an object returns the newly created object ID' do
        expect(subject).to eq id_through_create
      end
    end

    context 'when an API request raise ApiError' do
      before do
        allow(actions_mock).to receive(:create).with(data).and_raise(ZabbixApi::ApiError, 'ApiError occured.')
      end

      it 'propogates the ApiError raise by an API' do
        expect { subject }.to raise_error(ZabbixApi::ApiError, 'ApiError occured.')
      end
    end

    context 'when an API request raise HttpError' do
      before do
        allow(actions_mock).to receive(:create).with(data).and_raise(ZabbixApi::HttpError, 'HttpError occured.')
      end

      it 'propogates the HttpError raise by an API' do
        expect { subject }.to raise_error(ZabbixApi::HttpError, 'HttpError occured.')
      end
    end
  end
end
