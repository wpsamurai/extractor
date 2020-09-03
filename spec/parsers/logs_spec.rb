RSpec.describe Extractor::Parsers::Logs do
  describe '#parse' do
    subject (:parser) { described_class.new(filename) }

    context 'when log file does not exist' do
      let(:filename) { 'not_existing_path' }

      it 'raises an exception' do
        expect{ parser.parse }.to raise_error Errno::ENOENT
      end
    end

    context 'when log file is empty' do
      let(:filename) { "#{RSPEC_ROOT}/fixtures/empty.log" }

      it 'returns empty result' do
        expected_result = { hosts: [], files: [] }

        expect(parser.parse).to eq expected_result
      end
    end

    context 'when log file contains only empty lines' do
      let(:filename) { "#{RSPEC_ROOT}/fixtures/empty-lines.log" }

      it 'returns empty result' do
        expected_result = { hosts: [], files: [] }

        expect(parser.parse).to eq expected_result
      end
    end

    context 'when log file contains correct data' do
      let(:filename) { "#{RSPEC_ROOT}/fixtures/varnish.log" }

      it 'returns 5 hosts' do
        result = parser.parse

        expect(result[:hosts].count).to eq 5
      end

      it 'returns ordered hosts' do
        expected_result = [
          ['www.vg.no', 412],
          ['static.vg.no', 340],
          ['2.vgc.no', 169],
          ['1.vgc.no', 157],
          ['3.vgc.no', 120]
        ]

        result = parser.parse

        expect(result[:hosts]).to eq expected_result
      end

      it 'returns top 5 files' do
        result = parser.parse

        expect(result[:files].count).to eq 5
      end

      it 'returns ordered files' do
        expected_result = [
          ['http://www.vgtv.no/api/js/videoiframe.js', 19],
          ['http://www.vg.no/innstikk/vgfeed_3spalter_ny.php', 17],
          ['http://www.vg.no/tv-guide/schedule.php', 15],
          ['http://www.vg.no/innstikk/vgfeed_3spalter2_ny.php', 14],
          ['http://2.vgc.no/drfront/images/2012/05/23/c=70,0,669,470;w=286;h=201;42395.jpg', 14]
        ]

        result = parser.parse

        expect(result[:files]).to eq expected_result
      end
    end

    context 'with HTTP request' do
      context 'when log file does not exist' do
        let(:filename) { 'http://example.com/not_existing_file.log' }

        before(:each) do
          stub_request(:get, filename)
            .to_return(status: 404)
        end

        it 'raises an exception' do
          expect{ parser.parse }.to raise_error OpenURI::HTTPError
        end
      end

      context 'when log file is available' do
        let(:filename) { 'http://example.com/existing.log' }

        before(:each) do
          stub_request(:get, filename)
            .to_return(body: File.new("#{RSPEC_ROOT}/fixtures/empty.log"), status: 200)
        end

        it 'fetches the file' do
          expected_result = { hosts: [], files: [] }

          expect(parser.parse).to eq expected_result
        end
      end
    end
  end
end
