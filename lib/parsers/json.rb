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

        handler.items
      end

      class Handler < ::Oj::Saj
        ITEM_ATTR = %i[title full_url price].freeze

        attr_reader :items

        def initialize
          @items = []
        end

        def hash_start(_key)
          @item = {}
          @item_node = true
        end

        def add_value(value, key)
          return unless @item_node
          return if key.nil?
          return unless ITEM_ATTR.include?(key.to_sym)

          @item[key.to_sym] = value
        end

        def hash_end(_key)
          @item_node = false
          @items << @item
        end
      end
    end
  end
end
