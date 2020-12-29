require 'spec_helper'

describe 'ZabbixApi::ValueMaps' do
  let(:valuemaps_mock) { ZabbixApi::ValueMaps.new(client) }
  let(:client) { double }

  describe '.method_name' do
    subject { valuemaps_mock.method_name }

    it { is_expected.to eq 'valuemap' }
  end

  describe '.identify' do
    subject { valuemaps_mock.identify }

    it { is_expected.to eq 'name' }
  end

  describe '.key' do
    subject { valuemaps_mock.key }

    it { is_expected.to eq 'valuemapid' }
  end

  describe '.get_or_create' do
    subject { valuemaps_mock.get_or_create(data) }

    let(:data) { { valuemapids: %w[100 101 102 104] } }

    before do
      allow(valuemaps_mock).to receive(:log)
      allow(valuemaps_mock).to receive(:get_id).and_return(data[:valuemapids].first)
    end

    it 'logs debug message' do
      expect(valuemaps_mock).to receive(:log).with("[DEBUG] Call get_or_create with parameters: #{data.inspect}")
      subject
    end

    context 'when id is found' do
      it 'returns the id' do
        expect(subject).to eq data[:valuemapids].first
      end
    end

    context 'when id is not found' do
      before { allow(valuemaps_mock).to receive(:get_id) }

      it 'creates a new id' do
        expect(valuemaps_mock).to receive(:create).with(data)
        subject
      end
    end
  end

  describe '.create_or_update' do
    subject { valuemaps_mock.create_or_update(data) }

    let(:data) { { name: 'fake_valuemap_name' } }
    let(:id) { 123 }

    before { allow(valuemaps_mock).to receive(:get_id).with(name: data[:name]).and_return(id) }

    after { subject }
    context 'when id is found' do
      let(:update_data) { data.merge(valuemapids: [id]) }

      before do
        allow(data).to receive(:merge).with(valuemapids: [:valuemapid]).and_return(update_data)

        allow(valuemaps_mock).to receive(:update)
      end

      it 'updates the data valueid item' do
        expect(valuemaps_mock).to receive(:update).with(update_data)
      end
    end

    context 'when id is not found' do
      before do
        allow(valuemaps_mock).to receive(:get_id).with(name: data[:name])
        allow(valuemaps_mock).to receive(:create).with(data)
      end

      it 'creates a new valueid item' do
        expect(valuemaps_mock).to receive(:create).with(data)
      end
    end
  end
end
