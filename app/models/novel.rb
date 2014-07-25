class Novel < ActiveRecord::Base
  has_many :chapters, dependent: :destroy

  validates :title, :mode, presence: true
  validates :comment, :title, length: {maximum: 250}



end
