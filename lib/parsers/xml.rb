require 'open-uri'
require "ox"

module Extractor
  module Parsers
    class Xml
      def self.parse(file)
        new(file).parse
      end

      def initialize(file)
        @file = file
      end

      def parse
        handler = Handler.new

        URI.open(@file) do |f|
          Ox.sax_parse(handler, f)
        end

        handler.products
      end

      private

        class Handler < ::Ox::Sax
          PRODUCT_ATTR = [:title, :link, :'g:price']

          attr_reader :products

          def initialize
            @products = []
          end

          def start_element(name)
            @current_node = name

            return unless name == :item

            @product = {}
            @product_node = true
          end

          def text(value)
            return unless @product_node
            return unless PRODUCT_ATTR.include?(@current_node)
            @product[@current_node] = value
          end

          def end_element(name)
            return unless name == :item
            @product_node = false

            @products << @product
          end
        end
    end
  end
end
