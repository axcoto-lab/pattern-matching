require 'pp'
require_relative './analyzer/simple'

module PM

  class Finder
    attr_reader :patterns, :hostnames
    
    def initialize(hostnames)
      @hostnames = hostnames

      @patterns = []
    end

    def add(str)
      @patterns += str
    end

    def analyze()
      puts "Simple analyze result"
      analyzer = Object.const_get("PM::Analyzer::Simple").new
      analyzer.analyze(@hostnames)
    end

    def self.work!(source)
      pm = PM::Finder.new(PM::Input.read(source))

      host_segments = pm.analyze
      sorted_words = pm.count(host_segments)

      pp sorted_words
      pm
    end

    def count(array)
      occurences = {}
      array.each do |value|
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
