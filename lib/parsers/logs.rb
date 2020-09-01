require 'uri'
require 'open-uri'
module Extractor
  module Parsers
    class Logs
      def self.parse(file)
        new(file).parse
      end

      def initialize(file)
        @file = file
      end

      def parse
        hosts = {}
        files = {}

        URI.open(@file) do |f|
          f.each_line do |raw_line|
            line = clean_line(raw_line)
            next if line.empty?

            elements = line.split
            url = elements[6]
            uri = URI(url)

            hosts[uri.host] ||= 0
            hosts[uri.host] += 1

            file = url.delete_suffix("?#{uri.query}")
            next if File.extname(URI(file).path).empty?

            files[file] ||= 0
            files[file] += 1
          end
        end

        {
          hosts: hosts.sort_by { |_k, v| -v }.take(5),
          files: files.sort_by { |_k, v| -v }.take(5)
        }
      end

      private

      def clean_line(line)
        line.strip.chomp
      end
    end
  end
end
