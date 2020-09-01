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

      class Handler < ::Oj::Saj
        PRODUCT_ATTR = %i[title full_url price].freeze

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
          return if key.nil?
          return unless PRODUCT_ATTR.include?(key.to_sym)

          @product[key.to_sym] = value
        end

        def hash_end(_key)
          @product_node = false
          @products << @product
        end
      end
    end
  end
end
