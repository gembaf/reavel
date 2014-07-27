class Novel < ActiveRecord::Base
  has_many :chapters, dependent: :destroy

  accepts_nested_attributes_for :chapters

  validates :title, :mode, presence: true
  validates :comment, :title, length: {maximum: 250}

  Scope.active(self)
  Scope.updated_by(self)

  MODE = ["部 > 章 > 編 > 話", "部 > 章 > 話", "部 > 話"]

  def self.format_mode
    {
      MODE[0] => 0,
      MODE[1] => 1,
      MODE[2] => 2
    }
  end

  def self.format_select
    self.active.map do |novel|
      [novel.title, novel.id]
    end
  end
end

