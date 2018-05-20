class FantasyChapterCreateService
  def initialize(chapter, zip_file)
    @chapter = chapter
    @zip_file = zip_file
  end

  def call
    @story_index = 0
    index = @chapter.children.count + 1

    list.each.with_index(index) do |big_chapter_entity, i|
      big_chapter = Chapter.create(
        novel_id: @chapter.novel_id,
        parent_id: @chapter.id,
        title: big_chapter_entity.title,
        no: i,
      )

      big_chapter_entity.children.each.with_index(1) do |small_chapter_entity, j|
        small_chapter = Chapter.create(
          novel_id: @chapter.novel_id,
          parent_id: big_chapter.id,
          title: small_chapter_entity.title,
          no: j,
        )

        small_chapter_entity.children.each do |story_entity|
          FantasyStoryCreateService.new(
            chapter: small_chapter,
            title: story_entity.title,
            mht_path: mht_files[@story_index],
          ).call
          @story_index += 1
        end
      end
    end
  end

  private

  def manager
    @manager ||= Fantasy::ChapterManager.new(@zip_file)
  end

  def list
    @list ||= Fantasy::Command::CreateChapterList.execute(manager.chapter_list_file)
  end

  def mht_files
    @mht_files ||= manager.mht_files
  end

  def create_story(chapter, story_entity, no)
    mht = mht_files[@story_index]
    encode_text = Fantasy::Command::ScrapeMht.execute(mht)
    File.write(Rails.root.join)

    StoryCreateService.new(chapter: small_chapter, text: text, no: k)
    @story_index += 1
  end
end
