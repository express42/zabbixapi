require 'spec_helper'

describe 'ZabbixApi::Client' do
  let(:client_mock) { ZabbixApi::Client.new(options) }
  let(:options) { {} }
  let(:auth) { double }
  let(:api_version) { '4.0.0' }

  describe '.id' do
    subject { client_mock.id }

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_version).and_return('4.0.0')
      allow_any_instance_of(ZabbixApi::Client).to receive(:auth).and_return('auth')
    end

    it { is_expected.to be_kind_of Integer }

    it 'be in between 0 to 100_000' do
      expect_any_instance_of(ZabbixApi::Client).to receive(:rand).with(100_000)
      subject
    end
  end

  describe '.api_version' do
    subject { client_mock }

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:auth).and_return('4.0.0')
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_request).with(
        method: 'apiinfo.version', params: {}
      ).and_return('4.0.0')
    end

    it 'gets version using api_request ' do
      expect_any_instance_of(ZabbixApi::Client).to receive(:api_request).with(
        method: 'apiinfo.version', params: {}
      )
      subject
    end

    context 'when api_version is already set' do
      before do
        client_mock.instance_variable_set(:@api_version, '4.0.0')
      end

      it 'does not request an api for version ' do
        expect_any_instance_of(ZabbixApi::Client).not_to receive(:api_request).with(
          method: 'apiinfo.version', params: {}
        )
        subject
      end
    end
  end

  describe '.auth' do
    subject { client_mock }

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_version).and_return('4.0.0')
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_request).with(
        method: 'user.login',
        params: {
          user: nil,
          password: nil
        }
      )
    end

    it 'gets auth using api request' do
      expect_any_instance_of(ZabbixApi::Client).to receive(:api_request).with(
        method: 'user.login',
        params: {
          user: nil,
          password: nil
        }
      )
      subject
    end
  end

  describe '.initialize' do
    subject { client_mock }

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_version).and_return(api_version)
      allow_any_instance_of(ZabbixApi::Client).to receive(:auth).and_return('auth')
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_request).with(
        method: 'user.login',
        params: {
          user: nil,
          password: nil
        }
      )
    end

    context 'when proxy is provided and no_proxy flag is false' do
      let(:options) do
        {
          no_proxy: false
        }
      end

      before { allow(ENV).to receive(:[]).with('http_proxy').and_return('https://username:password@www.cerner.com') }

      it 'sets proxy class variables' do
        expect(subject.instance_variable_get(:@proxy_uri)).to be_kind_of(URI::HTTPS)
        expect(subject.instance_variable_get(:@proxy_host)).to eq('www.cerner.com')
        expect(subject.instance_variable_get(:@proxy_port)).to eq(443)
        expect(subject.instance_variable_get(:@proxy_user)).to eq('username')
        expect(subject.instance_variable_get(:@proxy_pass)).to eq('password')
      end

      it 'sets auth_hash' do
        expect(subject.instance_variable_get(:@auth_hash)).to eq('auth')
      end
    end

    context 'when proxy is provided and no_proxy flag is true' do
      let(:options) do
        {
          no_proxy: true
        }
      end

      before { allow(ENV).to receive(:[]).with('http_proxy').and_return('https://username:password@www.cerner.com') }

      it 'does not proxy class variables' do
        expect(subject.instance_variable_get(:@proxy_uri)).not_to be_kind_of(URI::HTTPS)
        expect(subject.instance_variable_get(:@proxy_host)).not_to eq('www.cerner.com')
        expect(subject.instance_variable_get(:@proxy_port)).not_to eq(443)
        expect(subject.instance_variable_get(:@proxy_user)).not_to eq('username')
        expect(subject.instance_variable_get(:@proxy_pass)).not_to eq('password')
      end

      it 'sets auth_hash' do
        expect(subject.instance_variable_get(:@auth_hash)).to eq('auth')
      end
    end

    context 'when proxy is not provided and no_proxy flag is false' do
      let(:options) do
        {
          no_proxy: false
        }
      end

      before { allow(ENV).to receive(:[]).with('http_proxy').and_return(nil) }

      it 'does not proxy class variables' do
        expect(subject.instance_variable_get(:@proxy_uri)).to be_nil
        expect(subject.instance_variable_get(:@proxy_host)).not_to eq('www.cerner.com')
        expect(subject.instance_variable_get(:@proxy_port)).not_to eq(443)
        expect(subject.instance_variable_get(:@proxy_user)).not_to eq('username')
        expect(subject.instance_variable_get(:@proxy_pass)).not_to eq('password')
      end

      it 'sets auth_hash' do
        expect(subject.instance_variable_get(:@auth_hash)).to eq('auth')
      end
    end

    context 'when major api_version is not supported' do
      let(:api_version) { 'not_a_valid_version' }

      before { allow(ENV).to receive(:[]).with('http_proxy').and_return(nil) }

      it 'sets auth_hash' do
        expect { subject }.to raise_error(ZabbixApi::ApiError, "Zabbix API version: #{api_version} is not supported by this version of zabbixapi")
      end
    end
  end

  describe '.message_json' do
    subject { client_mock.message_json(body) }

    let(:id) { 9090 }
    let(:generated_json) { { test: 'testjson' } }
    let(:method) { 'apiinfo.version' }
    let(:body) do
      {
        method: method,
        params: 'testparams'
      }
    end
    let(:message) do
      {
        method: method,
        params: 'testparams',
        id: id,
        jsonrpc: '2.0'
      }
    end

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_version).and_return('4.0.0')
      allow_any_instance_of(ZabbixApi::Client).to receive(:auth).and_return('auth')
      allow_any_instance_of(ZabbixApi::Client).to receive(:id).and_return(id)
      allow(JSON).to receive(:generate).with(message).and_return(generated_json)
    end

    context 'when method is apiinfo.version' do
      it 'adds auth information before generating json' do
        expect(subject).to eq generated_json
      end
    end

    context 'when method is user.login' do
      let(:method) { 'user.login' }

      it 'adds auth information before generating json' do
        expect(subject).to eq generated_json
      end
    end

    context 'when method is not `apiinfo.version` or `user.login`' do
      let(:method) { 'fakemethod' }
      let(:message) do
        {
          method: method,
          params: 'testparams',
          id: id,
          jsonrpc: '2.0',
          auth: 'auth'
        }
      end

      it 'adds auth information before generating json' do
        expect(subject).to eq generated_json
      end
    end
  end

  describe '.http_request' do
    subject { client_mock.http_request(body) }

    let(:mock_post) { double }
    let(:http_mock) { double }
    let(:http_proxy) { double }
    let(:timeout) { 60 }
    let(:response_code) { '200' }
    let(:response) { instance_double('HTTP::Response', code: response_code, body: { test: 'testbody' }) }
    let(:options) do
      {
        no_proxy: false,
        url: 'https://username:password@www.cerner.com'
      }
    end

    let(:body) { 'testbody ' }

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_version).and_return('4.0.0')
      allow_any_instance_of(ZabbixApi::Client).to receive(:auth).and_return('auth')
      allow(Net::HTTP).to receive(:Proxy).with(
        'www.cerner.com',
        443,
        'username',
        'password'
      ).and_return(http_proxy)

      allow(http_proxy).to receive(:new).with(
        'www.cerner.com',
        443
      ).and_return(http_mock)

      allow(ENV).to receive(:[])
        .with('http_proxy').and_return('https://username:password@www.cerner.com')
      allow(Net::HTTP::Post).to receive(:new).with('/').and_return(mock_post)
      allow(mock_post).to receive(:basic_auth).with('username', 'password')
      allow(mock_post).to receive(:add_field).with('Content-Type', 'application/json-rpc')
      allow(mock_post).to receive(:body=).with(body)
      allow(http_mock).to receive(:request).with(mock_post).and_return(response)
      allow(http_mock).to receive(:use_ssl=).with(true)

      allow(http_mock).to receive(:verify_mode=).with(0)
      allow(http_mock).to receive(:open_timeout=).with(timeout)
      allow(http_mock).to receive(:read_timeout=).with(timeout)
      allow(OpenSSL::SSL).to receive(:VERIFY_NONE).and_return(true)
      allow(response).to receive(:[]).with('error').and_return('Test error')
    end

    context 'when response code is 200' do
      it 'returns the response body' do
        expect(subject).to eq(test: 'testbody')
      end
    end

    context 'when response code is not 200' do
      let(:response_code) { '404' }

      it 'raises HttpError' do
        expect { subject }.to raise_error(ZabbixApi::HttpError, "HTTP Error: #{response_code} on #{options[:url]}")
      end
    end

    context 'when timeout is given as an option' do
      let(:timeout) { 300 }
      let(:options) do
        {
          no_proxy: false,
          url: 'https://username:password@www.cerner.com',
          timeout: timeout
        }
      end

      it 'sets provided timeout' do
        expect(http_mock).to receive(:open_timeout=).with(timeout)
        expect(http_mock).to receive(:read_timeout=).with(timeout)
        subject
      end
    end

    context 'when proxy_uri is not provided' do
      let(:options) do
        {
          no_proxy: true,
          url: 'https://username:password@www.cerner.com'
        }
      end

      before do
        allow_any_instance_of(ZabbixApi::Client).to receive(:api_version).and_return('4.0.0')
        allow_any_instance_of(ZabbixApi::Client).to receive(:auth).and_return('auth')
        allow(Net::HTTP).to receive(:new).with(
          'www.cerner.com',
          443
        ).and_return(http_mock)
      end

      it 'create http object without proxy' do
        expect(Net::HTTP).not_to receive(:Proxy).with(
          'www.cerner.com',
          443,
          'username',
          'password'
        )
        subject
      end
    end

    context 'when debug is set to true' do
      let(:options) do
        {
          no_proxy: false,
          url: 'https://username:password@www.cerner.com',
          debug: true
        }
      end

      before do
        allow_any_instance_of(ZabbixApi::Client).to receive(:puts)
      end

      it 'logs messages' do
        expect_any_instance_of(ZabbixApi::Client).to receive(:puts)
          .with("[DEBUG] Timeout for request set to #{timeout} seconds")
        expect_any_instance_of(ZabbixApi::Client).to receive(:puts)
          .with("[DEBUG] Get answer: #{response.body}")
        subject
      end
    end
  end

  describe '._request' do
    subject { client_mock._request(body) }

    let(:options) { { debug: true } }
    let(:response) { double }
    let(:body) do
      {
        params: 'testparams'
      }
    end
    let(:result) do
      {
        'result' => 'testresult'
      }
    end

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_version).and_return('4.0.0')
      allow_any_instance_of(ZabbixApi::Client).to receive(:auth).and_return('auth')
      allow_any_instance_of(ZabbixApi::Client).to receive(:pretty_body)
      allow_any_instance_of(ZabbixApi::Client).to receive(:http_request).with(body).and_return(response)
      allow(JSON).to receive(:parse).with(response).and_return(result)
    end

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:puts)
    end

    it 'logs DEBUG message' do
      expect_any_instance_of(ZabbixApi::Client).to receive(:puts)
        .with("[DEBUG] Send request: #{body}")
      subject
    end

    it 'returns result from the response' do
      expect(subject).to eq 'testresult'
    end

    context 'when result contains error' do
      let(:result) do
        {
          'error' => 'testresult'
        }
      end

      it 'raises ApiError' do
        expect { subject }.to raise_error(ZabbixApi::ApiError, /Server answer API error/)
      end
    end
  end

  describe '.pretty_body' do
    subject { client_mock.pretty_body(body) }

    let(:body) do
      "{
        \"params\": \"testparams\"
      }"
    end
    let(:parsed_body) do
      "{\n  \"params\": \"testparams\"\n}"
    end
    let(:result) do
      {
        'result' => 'testresult'
      }
    end

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_version).and_return('4.0.0')
      allow_any_instance_of(ZabbixApi::Client).to receive(:auth).and_return('auth')
    end

    context 'when body doesn not contain password as param' do
      it 'returns unparsed body' do
        expect(subject).to eq parsed_body
      end
    end

    context 'when body contains password as param' do
      let(:body) do
        "{
          \"params\": { \"password\": \"123pass\"}
        }"
      end
      let(:parsed_body) do
        "{\n  \"params\": {\n    \"password\": \"***\"\n  }\n}"
      end

      it 'changes password to `***`' do
        expect(subject).to eq parsed_body
      end
    end
  end

  describe '.api_request' do
    subject { client_mock.api_request(body) }

    let(:body) do
      "{
        \"params\": \"testparams\"
      }"
    end
    let(:message_json) do
      "{\n  \"params\": \"testparams\"\n}"
    end
    let(:result) do
      {
        'result' => 'testresult'
      }
    end

    before do
      allow_any_instance_of(ZabbixApi::Client).to receive(:api_version).and_return('4.0.0')
      allow_any_instance_of(ZabbixApi::Client).to receive(:auth).and_return('auth')
      allow_any_instance_of(ZabbixApi::Client).to receive(:message_json).with(body).and_return(message_json)
      allow_any_instance_of(ZabbixApi::Client).to receive(:_request).with(message_json).and_return(result)
    end

    it { is_expected.to eq result }
  end
end
