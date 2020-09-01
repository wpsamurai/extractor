#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative 'lib/console/options.rb'
require_relative 'lib/parser.rb'
require_relative 'lib/parsers/logs.rb'
require_relative 'lib/parsers/xml.rb'
require_relative 'lib/parsers/json.rb'
require_relative 'lib/formatter.rb'
require_relative 'lib/formatters/json.rb'
require_relative 'lib/formatters/xml.rb'
require_relative 'lib/formatters/logs.rb'

begin
  options = Extractor::Console::Options.parse(ARGV)

  parser_class = Extractor::Parser.build(options[:parser])
  formatter_class = Extractor::Formatter.build(options[:parser])

  ARGV.each do |filename|
    parser = parser_class.new(filename)
    puts formatter_class.new(parser.parse).render
  end
rescue => e
  puts e.message
end
