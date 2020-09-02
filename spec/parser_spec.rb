RSpec.describe Extractor::Parser do
  describe '.build' do
    context 'when the parser class exists' do
      it 'returns parser class with a module' do
        parser_name = :logs

        expect(described_class.build(parser_name).to_s).to eq 'Extractor::Parsers::Logs'
      end

      it 'returns parser class with a module for a string' do
        parser_name = 'xml'

        expect(described_class.build(parser_name).to_s).to eq 'Extractor::Parsers::Xml'
      end
    end

    context 'when the parser class is missing' do
      it 'raises an exception' do
        parser_name = 'not_existing_parser'

        expect{ described_class.build(parser_name) }.to raise_exception NameError
      end
    end
  end
end
