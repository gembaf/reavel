class Chapter < ActiveRecord::Base
  belongs_to :novel
  has_many :parts, dependent: :destroy

  accepts_nested_attributes_for :parts

  validates :novel_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  Scope.active(self)
  Scope.serial_by(self)
  Scope.updated_by(self)

end

