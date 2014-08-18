class Part < ActiveRecord::Base
  belongs_to :chapter
  has_many :volumes, dependent: :destroy

  accepts_nested_attributes_for :volumes

  validates :chapter_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  VOLUME_LIMIT = 10

  Scope.active(self)
  Scope.serial_by(self)
  Scope.active_by(self)

  def build_volumes
    VOLUME_LIMIT.times {self.volumes.build}
  end

  def toggle_active(params)
    ModelHelper.toggle_active(parents(self), self.time, self.episode, params[:is_active])
    self.update_attributes(params)
  end

  # override
  def self.create(params)
    part = self.where(chapter_id: params[:chapter_id]).last
    params[:serial] = ModelHelper.get_serial(part)
    super params
  end

  private
  def parents(part)
    chapter = part.chapter
    novel = chapter.novel
    [chapter, novel]
  end
end

