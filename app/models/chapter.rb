class Chapter < ActiveRecord::Base
  default_scope { order("serial") }

  belongs_to :novel
  has_many :parts, dependent: :destroy

  accepts_nested_attributes_for :parts

  validates :novel_id, :title, presence: true
  validates :title, :comment, length: {maximum: 250}

  Scope.active(self)
  Scope.serial_by(self)
  Scope.active_by(self)

  # override
  def self.create(params)
    chapter = self.where(novel_id: params[:novel_id]).last
    params[:serial] = ModelHelper.get_serial(chapter)
    super params
  end
end

