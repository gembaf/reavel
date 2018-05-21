module Fantasy
  module Command
    class ScrapeHtml
      THRESHOLD = 350 # 閾値以上のテキストを本文とみなす(それ以外はコメント)

      def self.execute(path)
        new.execute(path)
      end

      def execute(path)
        doc = Reavel::Nokogiri.parse(path)
        sections = doc.xpath('//blockquote')
        sections.shift # 最初の一つは必ず概要なので無視
        # コメントでTHRESHOLDを超えるものがあった場合の対策
        # 本文は最初の方 & コメントは後半に来るだろうという予想
        targets = sections.select { |s| s.text.length > THRESHOLD }
        Rails.logger.info("[ScrapeHtml] targes.count >= 5") if targets.count > 5

        targets.map do |target|
          target.children.select(&:text?).map(&:text).join("\n")
        end.join("\n\n")
      end
    end
  end
end
