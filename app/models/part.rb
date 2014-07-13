class Part < ActiveRecord::Base
  belongs_to :chapter
  has_many :stories

  validates :chapter_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}
end

