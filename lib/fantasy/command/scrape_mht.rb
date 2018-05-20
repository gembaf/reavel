module Fantasy
  module Command
    class ScrapeMht
      def self.execute(path)
        new.execute(path)
      end

      def execute(path)
        data = Reavel::Iconv.encode(File.read(path))
        sections = data.split(/\r\n------=_NextPart.*?\r\n/)
        target = sections.select { |sec| sec =~ %r{^Content-Type: text/html} }.first
        base64_text = target.split(/\r\n\r\n/).last
        base64_text.gsub(/\r\n/, '')
      end
    end
  end
end
