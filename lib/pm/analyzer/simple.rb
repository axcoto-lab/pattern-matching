module PM
  module Analyzer
    # Simple analyzer, turn hostname into tokens and count the occurence
    class Simple
      TOKEN_SEP = ['-', '_', ':', ' ', ';', ',', '.']

      def tokenize(hostnames)
        hostnames.map do |name|
          name.split(/[-_\:\s;,\.]/).map { |v| PM::Input.strip(v, TOKEN_SEP) }
        end.flatten.reject(&:empty?)
      end

      def analyze(hostnames)
        tokenize_hostnames = tokenize(hostnames)
        tokenize_hostnames
      end
    end
  end
end
