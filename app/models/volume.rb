class Volume < ActiveRecord::Base
  belongs_to :part
  has_many :stories, dependent: :delete_all

  accepts_nested_attributes_for :stories

  validates :part_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  Scope.active(self)
  Scope.serial_by(self)
  Scope.active_by(self)

  STORY_LIMIT = 20

  def build_stories
    STORY_LIMIT.times {self.stories.build}
  end

  def toggle_active(params)
    ModelHelper.toggle_active(parents(self), self.time, self.episode, params[:is_active])
    self.update_attributes(params)
  end

  # override
  def self.create(params)
    volume = self.where(part_id: params[:part_id]).last
    params[:serial] = ModelHelper.get_serial(volume)
    super params
  end

  private
  def parents(volume)
    part = volume.part
    chapter = part.chapter
    novel = chapter.novel
    [part, chapter, novel]
  end
end

