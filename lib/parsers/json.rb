require 'open-uri'
require 'oj'

module Extractor
  module Parsers
    class Json
      def self.parse(file)
        new(file).parse
      end

      def initialize(file)
        @file = file
      end

      def parse
        handler = Handler.new

        URI.open(@file) do |f|
          Oj.saj_parse(handler, f)
        end

        handler.products
      end

      private

        class Handler < ::Oj::Saj
          PRODUCT_ATTR = %w[title full_url price]

          attr_reader :products

          def initialize
            @products = []
          end

          def hash_start(_key)
            @product = {}
            @product_node = true
          end

          def add_value(value, key)
            return unless @product_node
            return unless PRODUCT_ATTR.include?(key)

            @product[key] = value
          end

          def hash_end(_key)
            @product_node = false
            @products << @product
          end
        end
    end
  end
end