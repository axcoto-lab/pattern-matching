require 'pp'
require_relative './analyzer/simple'
require_relative './analyzer/non-deliminator'

module PM

  class Finder
    attr_reader :patterns, :hostnames
    THRESHOLD = 3

    def initialize(hostnames)
      @hostnames = hostnames

      @patterns = []
    end

    def add(str)
      @patterns += str
    end

    # Analyze data
    def analyze
      analyzer = Object.const_get("PM::Analyzer::#{ENV['ANALYZER'] || 'Simple'}").new
      analyzer.analyze(@hostnames)
    end

    def self.work!(args)
      source = args[:file]
      pm = PM::Finder.new(PM::Input.read(source))

      host_segments = pm.analyze
      sorted_words = pm.count(host_segments)

      #sorted_words.reject! { |v| v[1] <= THRESHOLD }

      pp sorted_words
      pm
    end

    def ignore_filters?(value)
      value.match(/^[0-9]+$/)
    end

    def count(array)
      occurences = {}
      array.each do |value|
        next if ignore_filters?(value)

        value.downcase!
        if occurences[value].nil?
          occurences[value] = 1
        else
          occurences[value] += 1
        end
      end
      occurences.sort_by { |k,v| -v }
    end
  end
end
