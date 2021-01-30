require 'spec_helper'

describe 'ZabbixApi::Mediatypes' do
  let(:mediatypes_mock) { ZabbixApi::Mediatypes.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { mediatypes_mock.method_name }

    it { is_expected.to eq 'mediatype' }
  end

  describe '.identify' do
    subject { mediatypes_mock.identify }

    it { is_expected.to eq 'name' }
  end

  describe '.default_options' do
    subject { mediatypes_mock.default_options }

    let(:result) do
      {
        name: '',
        description: '',
        type: 0,
        smtp_server: '',
        smtp_helo: '',
        smtp_email: '',
        exec_path: '',
        gsm_modem: '',
        username: '',
        passwd: ''
      }
    end

    it { is_expected.to eq result }
  end
end
