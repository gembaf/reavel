class StoryCreateService
  def initialize(text:, title: nil, comment: nil, is_scene: false)
    @text = text
    @title = title
    @comment = comment
    @is_scene = is_scene
  end

  def call
    uuid = SecureRandom.uuid
    no = 1
    time = Story.required_time(@text)

    ActiveRecord::Base.transaction do
      story = Story.create(
        title: @title,
        comment: @comment,
        is_scene: @is_scene,
        uuid: uuid,
        no: no,
        time: time,
      )

      story.write(@text)
      story
    end
  end
end
