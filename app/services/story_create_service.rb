class StoryCreateService
  def initialize(chapter:, text:, **args)
    @chapter = chapter
    @text = text
    @params = args
  end

  def call
    uuid = SecureRandom.uuid
    no = @chapter.stories.count + 1
    time = Story.required_time(@text)

    ActiveRecord::Base.transaction do
      story = Story.create(
        chapter: @chapter,
        uuid: uuid,
        no: no,
        time: time,
        **@params,
      )

      story.write(@text)
      story
    end
  end
end
