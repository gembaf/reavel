class Novel < ActiveRecord::Base
  has_many :chapters, dependent: :destroy

  validates :title, :mode, presence: true
  validates :comment, :title, length: {maximum: 250}

  Scope.active(self)
  Scope.serial_by(self)
  Scope.updated_by(self)

  Mode = ["部 > 章 > 編 > 話", "部 > 章 > 話", "部 > 話"]

  def self.mode_format
    {
      Mode[0] => 0,
      Mode[1] => 1,
      Mode[2] => 2
    }
  end

end

