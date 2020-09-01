require 'open-uri'
require 'ox'

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

        handler.items
      end

      class Handler < ::Ox::Sax
        ITEM_ATTR = %i[title link g:price].freeze

        attr_reader :items

        def initialize
          @items = []
          @item_node = false
        end

        def start_element(name)
          @current_node = name

          return unless name == :item

          @item = {}
          @item_node = true
        end

        def text(value)
          return unless @item_node
          return unless ITEM_ATTR.include?(@current_node)

          @item[@current_node] = value
        end

        def end_element(name)
          return unless name == :item

          @item_node = false

          @items << @item
        end
      end
    end
  end
end
