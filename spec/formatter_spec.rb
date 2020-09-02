RSpec.describe Extractor::Formatter do
  describe '.build' do
    context 'when the formatter class exists' do
      it 'returns formatter class with a module' do
        formatter_name = :logs

        expect(described_class.build(formatter_name).to_s).to eq 'Extractor::Formatters::Logs'
      end

      it 'returns formatter class with a module for a string' do
        formatter_name = 'xml'

        expect(described_class.build(formatter_name).to_s).to eq 'Extractor::Formatters::Xml'
      end
    end

    context 'when the formatter class is missing' do
      it 'raises an exception' do
        formatter_name = 'not_existing_formatter'

        expect{ described_class.build(formatter_name) }.to raise_exception NameError
      end
    end
  end
end
