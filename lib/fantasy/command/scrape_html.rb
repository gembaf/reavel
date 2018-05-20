module Fantasy
  module Command
    class ScrapeHtml
      THRESHOLD = 300 # 閾値以上のテキストを本文とみなす(それ以外はコメント)

      def self.execute(path)
        new.execute(path)
      end

      def execute(path)
        doc = Reavel::Nokogiri.parse(path)
        sections = doc.xpath('//blockquote')
        # コメントでTHRESHOLDを超えるものがあった場合の対策
        # 本文は最初の方 & コメントは後半に来るだろうという予想
        targets = sections.select { |s| s.text.length > THRESHOLD }.slice(0..4)

        targets.map do |target|
          target.children.select(&:text?).map(&:text).join("\n")
        end.join("\n\n")
      end
    end
  end
end
