class Story < ActiveRecord::Base
  belongs_to :volume

  validates :volume_id, :title, :contents, presence: true
  validates :title, :comment, length: {maximum: 250}

  mount_uploader :contents, TextUploader

  Scope.active(self)
  Scope.serial_by(self)
  Scope.active_by(self)

end

