class Part < ActiveRecord::Base
  belongs_to :chapter
  has_many :volumes, dependent: :destroy

  accepts_nested_attributes_for :volumes

  validates :chapter_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  Scope.active(self)
  Scope.serial_by(self)
  Scope.active_by(self)

  # override
  def self.create(params)
    part = self.where(chapter_id: params[:chapter_id]).last
    params[:serial] = ModelHelper.get_serial(part)
    super params
  end
end

