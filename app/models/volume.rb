class Volume < ActiveRecord::Base
  belongs_to :part
  has_many :stories, dependent: :delete_all

  accepts_nested_attributes_for :stories

  validates :part_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  Scope.active(self)
  Scope.serial_by(self)
  Scope.active_by(self)

end

