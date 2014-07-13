class Story < ActiveRecord::Base
  belongs_to :part

  validates :part_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}
end

