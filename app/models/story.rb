class Story < ActiveRecord::Base
  belongs_to :volume

  validates :volume_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}
end

