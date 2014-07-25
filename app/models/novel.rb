class Novel < ActiveRecord::Base
  has_many :chapters, dependent: :destroy

  validates :title, :mode, presence: true
  validates :comment, :title, length: {maximum: 250}

  Scope.active(self)
  Scope.serial_by(self)
  Scope.updated_by(self)


end

