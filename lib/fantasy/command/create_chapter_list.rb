module Fantasy
  module Command
    class CreateChapterList
      TYPE_STORY = :story
      TYPE_SMALL_CHAPTER = :small_chapter
      TYPE_BIG_CHAPTER = :big_chapter

      def self.execute(path)
        new.execute(path)
      end

      def execute(path)
        lines = Reavel::Iconv.read_and_split(path)
        lines = lines.delete_if { |line| line.blank? }

        result = []
        lines.each do |line|
          case title_type(line)
          when TYPE_BIG_CHAPTER
            result << Reavel::Entity::ChapterEntity.new(title: big_chapter_title(line))
          when TYPE_SMALL_CHAPTER
            children = result.last.children
            children << Reavel::Entity::ChapterEntity.new(title: small_chapter_title(line))
          when TYPE_STORY
            children = result.last.children.last.children
            children << Reavel::Entity::ChapterEntity.new(title: story_title(line))
          end
        end
        result
      end

      def title(line)
        case title_type(line)
        when TYPE_STORY
          story_title(line)
        when TYPE_SMALL_CHAPTER
          small_chapter_title(line)
        when TYPE_BIG_CHAPTER
          big_chapter_title(line)
        end
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

      def title_type(line)
        line.match(%r{^●}) { return TYPE_BIG_CHAPTER }
        line.match(%r{^・(.*?)編$}) { return TYPE_SMALL_CHAPTER }
        line.match(%r{\(1/(5|6)\)}) { return TYPE_STORY }
        raise
      end
    end
  end
end
