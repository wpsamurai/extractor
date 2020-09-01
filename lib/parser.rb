# frozen_string_literal: true

module Extractor
  class Parser
    def self.build(parser)
      Object.const_get(
        "Extractor::Parsers::#{parser.capitalize}"
      )
    end
  end
end
