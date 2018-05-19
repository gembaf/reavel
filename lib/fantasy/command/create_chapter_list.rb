module Fantasy
  module Command
    class CreateChapterList
      def self.execute
        new.execute
      end

      def execute
        'hoge'
      end

      def story_title(line)
        line.split(/　/).last.sub(%r{\(1/5\)}, '')
      end

      def small_chapter_title(line)
        line.match(/・(.*?)編/)[1]
      end

      def big_chapter_title(line)
        line.split(/：/).last
      end
    end
  end
end
