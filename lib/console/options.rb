# frozen_string_literal: true
require 'optparse'

module Extractor
  module Console
    class Options
      DEFAULT_OPTIONS = {
          parser: :logs
      }

      def self.parse(args)
        options = DEFAULT_OPTIONS

        parser = OptionParser.new do |opts|
          opts.banner = "Usage: extractor.rb [options] file"

          opts.on(
              '-pPARSER',
              '--parser=PARSER',
              "Select parser (default: #{DEFAULT_OPTIONS[:parser]})"
          ) do |p|
            options[:parser] = p
          end

          opts.on('-h', '--help', 'Displays help') do
            puts opts
            exit
          end
        end

        parser.parse!(args)

        options.transform_values(&:to_sym)
      end
    end
  end
end
