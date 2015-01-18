class Part < ActiveRecord::Base
  belongs_to :chapter
  has_many :volumes, dependent: :destroy

  accepts_nested_attributes_for :volumes

  validates :chapter_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  VOLUME_LIMIT = 10

  default_scope -> {where(is_active: true).order("serial")}
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
    if part = Part.where(chapter_id: chapter.id, serial: self.serial+1).first
      return part
    end
    return nil unless next_chapter = chapter.next
    next_chapter.parts.first
  end

  def prev
    chapter = self.chapter
    if part = Part.where(chapter_id: chapter.id, serial: self.serial-1).first
      return part
    end
    return nil unless prev_chapter = chapter.prev
    prev_chapter.parts.last
  end

  def set_serial
    part = Part.where(chapter_id: self.chapter_id).last
    self.serial = ModelHelper.get_serial(part)
  end

  private
  def parents(part)
    chapter = part.chapter
    novel = chapter.novel
    [chapter, novel]
  end
end

