module PM
  module Analyzer
    # Simple analyzer, turn hostname into tokens and count the occurence
    class NonDeliminator
      TOKEN_SEP = ['-', '_', ':', ' ', ';', ',', '.']

      def tokenize(hostnames)
        hostnames = hostnames.map do |name|
          name.split(/[-_\:\s;,\.]/).map { |v| PM::Input.strip(v, TOKEN_SEP) }
        end.flatten.reject(&:empty?)

        hostnames = hostnames.map do |name|
          words = []
          name.length.times do |i|
            value = name[0..i]
                          .sub(/^[\s0-9]+/, '')
                          .sub(/[\s0-9]+$/, '')
                          .strip
            words << value unless words.include? value
          end
          words
        end.flatten.reject(&:empty?).reject { |s| s.length <2 }

        tokenized_names = []
        hostnames.each do |name|
          sub_matched     = 0
          exactly_matched = 0

          # If a word is a sub strig of another words, we count the occurence
          # of that parent words. If parent words occurs more often than sub words
          # we choose parent words, and dismissed sub words
          hostnames.each do |h|
            if h.include?(name) && h.length > name.length
              if count_occurence(hostnames, h) >= 2
                sub_matched += 1
              end
            end
            if h == name
              exactly_matched += 1
            end
          end

          if sub_matched < exactly_matched
            tokenized_names << name
          end
        end
        tokenized_names
      end

      def count_occurence(array, value)
        array.inject(0) do |sum, n|
          sum += 1 if value == n
          sum
        end
      end

      def analyze(hostnames)
        tokenize_hostnames = tokenize(hostnames)
        tokenize_hostnames
      end
    end
  end
end
