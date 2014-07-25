class Chapter < ActiveRecord::Base
  belongs_to :novel
  has_many :parts, dependent: :destroy

  validates :novel_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}
end

