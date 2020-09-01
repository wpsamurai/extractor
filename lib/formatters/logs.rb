require 'terminal-table'

module Extractor
  module Formatters
    class Logs
      def initialize(hash)
        @hash = hash
      end

      def render
        output = []

        output << 'Top 5 hosts'
        output << ::Terminal::Table.new(
            headings: %w[Hostname Hits],
            rows: result[:hosts].to_a
        )

        output << 'Top 5 files'
        output << ::Terminal::Table.new(
            headings: %w[File Hits],
            rows: result[:files].to_a
        )

        output
      end

      private

        def result
          @hash
        end
    end
  end
end