require 'terminal-table'

module Extractor
  module Formatters
    class Json
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
          .sort_by { |product| product['price'].split.first.to_f }
          .map { |product| [product['title'], product['price'], product['full_url']] }
      end
    end
  end
end
