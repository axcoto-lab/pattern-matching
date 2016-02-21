module PM
  module Input
    TOKEN_SEP = [':', '-', ' ', '_', ';', ',']

    class << self
      def read(source)
        lines = []
        File.open(source).each do |line|
          next if line.strip.empty?

          lines << strip(line.strip) unless line.strip.empty?
        end
        lines
      end

      def strip(s, tokens = nil)
        tokens = TOKEN_SEP if tokens.nil?
        while !s.nil? && tokens.include?(s[0])
          s = s[1..-1]
        end
        while !s.nil? && tokens.include?(s[-1])
          s = s[0..-2]
        end
        s
      end
    end
  end
end
