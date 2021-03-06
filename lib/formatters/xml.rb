require 'terminal-table'

module Extractor
  module Formatters
    class Xml
      def initialize(hash)
        @hash = hash
      end

      def render
        ::Terminal::Table.new(
          headings: %w[Title Price Url],
          rows: result
        )
      end

      private

        def result
          @hash
            .sort_by { |item| item[:'g:price'].split.first.to_f }
            .map { |item| [item[:title], item[:'g:price'], item[:link]] }
        end
    end
  end
end
