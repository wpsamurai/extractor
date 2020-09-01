# frozen_string_literal: true

module Extractor
  class Formatter
    def self.build(parser)
      Object.const_get(
        "Extractor::Formatters::#{parser.capitalize}"
      )
    end
  end
end
