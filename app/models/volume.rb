class Volume < ActiveRecord::Base
  belongs_to :part
  has_many :stories, dependent: :delete_all

  accepts_nested_attributes_for :stories

  validates :part_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  default_scope -> {where(is_active: true).order("serial")}
  Scope.serial_by(self)
  Scope.active_by(self)

  STORY_LIMIT = 15

  def build_stories
    STORY_LIMIT.times {self.stories.build}
  end

  def toggle_active(params)
    ModelHelper.toggle_active(parents(self), self.time, self.episode, params[:is_active])
    self.update_attributes(params)
  end

  def next
    part = self.part
    if volume = Volume.where(part_id: part.id, serial: self.serial+1).first
      return volume
    end
    return nil unless next_part = part.next
    next_part.volumes.first
  end

  def prev
    part = self.part
    if volume = Volume.where(part_id: part.id, serial: self.serial-1).first
      return volume
    end
    return nil unless prev_part = part.prev
    prev_part.volumes.last
  end

  def set_serial
    volume = Volume.where(part_id: self.part_id).last
    self.serial = ModelHelper.get_serial(volume)
  end

  private
  def parents(volume)
    part = volume.part
    chapter = part.chapter
    novel = chapter.novel
    [part, chapter, novel]
  end
end

