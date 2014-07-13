class Novel < ActiveRecord::Base
  has_many :chapters

  validates :title, :mode, presence: true
  validates :comment, :title, length: {maximum: 250}



end
