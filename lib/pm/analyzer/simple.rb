module PM
  module Analyzer
    # Simple analyzer, turn hostname into tokens and count the occurence
    class Simple
      TOKEN_SEP = ['-', '_', ':', ' ', ';', ',']

      def tokenize(hostnames)
        hostnames.map do |name|
          words = []
          TOKEN_SEP.each do |splitor|
            if name.include? splitor
              words << name.split(splitor).map { |segment| PM::Input.strip(segment, TOKEN_SEP) }
              break
            end
          end
          words
        end.reject!(&:empty?).flatten
      end

      def analyze(hostnames)
        tokenize_hostnames = tokenize(hostnames)
        tokenize_hostnames
      end
    end
  end
end
