class Chapter < ActiveRecord::Base
  belongs_to :novel
  has_many :parts, dependent: :destroy

  accepts_nested_attributes_for :parts

  validates :novel_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  PART_LIMIT = 10

  default_scope -> {where(is_active: true).order("serial")}
  Scope.serial_by(self)
  Scope.active_by(self)

  def build_parts
    PART_LIMIT.times {self.parts.build}
  end

  def toggle_active(params)
    ModelHelper.toggle_active([self.novel], self.time, self.episode, params[:is_active])
    self.update_attributes(params)
  end

  def next
    novel = self.novel
    Chapter.where(novel_id: novel.id, serial: self.serial+1).first
  end

  def prev
    novel = self.novel
    Chapter.where(novel_id: novel.id, serial: self.serial-1).first
  end

  def set_serial
    chapter = Chapter.where(novel_id: self.novel_id).last
    self.serial = ModelHelper.get_serial(chapter)
  end

  def skip_create
    mode = self.novel.mode
    unless mode == Novel::MODE_LONG
      part = Part.create(chapter_id: self.id, title: "_skip")
      if mode == Novel::MODE_SHORT
        Volume.create(part_id: part.id, title: "_skip")
      end
    end
  end
end

