class Chapter < ActiveRecord::Base
  belongs_to :novel
  has_many :parts

  validates :novel_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}
end

