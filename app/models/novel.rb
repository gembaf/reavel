class Novel < ActiveRecord::Base
  has_many :chapters, dependent: :destroy

  accepts_nested_attributes_for :chapters

  validates :title, :mode, presence: true
  validates :comment, :title, length: {maximum: 250}

  Scope.active(self)
  Scope.serial_by(self)
  Scope.updated_by(self)

  MODE = ["部 > 章 > 編 > 話", "部 > 章 > 話", "部 > 話"]

  def self.mode_format
    {
      MODE[0] => 0,
      MODE[1] => 1,
      MODE[2] => 2
    }
  end

end

