class Novel < ActiveRecord::Base
  has_many :chapters, dependent: :destroy
  has_many :images, dependent: :delete_all

  accepts_nested_attributes_for :chapters

  validates :title, :mode, presence: true
  validates :comment, :title, length: {maximum: 250}

  default_scope {where(is_active: true)}
  Scope.updated_by(self)
  Scope.active_by(self)

  MODE_LONG = 0
  MODE_MIDDLE = 1
  MODE_SHORT = 2

  CHAPTER_LIMIT = 10

  def self.format_mode
    {
      "部 > 章 > 編 > 話" => MODE_LONG,
      "部 > 編 > 話"      => MODE_MIDDLE,
      "部 > 話"           => MODE_SHORT
    }
  end

  def self.format_select
    self.active.map do |novel|
      [novel.title, novel.id]
    end
  end

  def build_chapters
    CHAPTER_LIMIT.times {self.chapters.build}
  end
end

