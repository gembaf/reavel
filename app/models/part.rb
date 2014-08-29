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

  def next
    chapter = self.chapter
    part = Part.where(chapter_id: chapter.id, serial: self.serial+1).first

    return part if part.present?

    return nil if (next_chapter = chapter.next).nil?
    next_chapter.parts.active.serial_by.first
  end

  def prev
    chapter = self.chapter
    part = Part.where(chapter_id: chapter.id, serial: self.serial-1).first

    return part if part.present?

    return nil if (prev_chapter = chapter.prev).nil?
    prev_chapter.parts.active.serial_by.last
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

