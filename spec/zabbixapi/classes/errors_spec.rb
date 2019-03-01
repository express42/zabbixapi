require 'spec_helper'

describe 'ZabbixApi::BaseError' do
  let(:error_mock) { ZabbixApi::BaseError.new(message, response) }
  let(:message) { 'Test Message' }
  let(:response) { { 'error' => { 'data' => error_data, 'message' => error_message } } }
  let(:error_data) { 'Program is borked' }
  let(:error_message) { 'something has gone wrong' }

  describe '.initialize' do
    subject { error_mock }

    it 'calls super with error message' do
      expect_any_instance_of(RuntimeError).to receive(:initialize).with(message)
      subject
    end

    context 'when response is passed in' do
      it 'response class variable should be set' do
        expect(subject.instance_variable_get(:@response)).to eq response
      end

      it 'error class variable should be set' do
        expect(subject.instance_variable_get(:@error)).to eq response['error']
      end

      it 'error message class variable should be set' do
        expect(subject.instance_variable_get(:@error_message)).to eq "#{error_message}: #{error_data}"
      end
    end

    context 'when response is not passed in' do
      let(:response) { nil }

      it 'should not set response class variable' do
        expect(subject.instance_variable_get(:@response)).to be_nil
      end

      it 'should not set error class variable' do
        expect(subject.instance_variable_get(:@error)).to be_nil
      end

      it 'should not set error message class variable' do
        expect(subject.instance_variable_get(:@error_message)).to be_nil
      end
    end
  end
end
