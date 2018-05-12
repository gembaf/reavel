# == Schema Information
#
# Table name: chapters
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  comment    :string(255)
#  no         :integer          not null
#  novel_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level      :integer          default(1), not null
#  parent_id  :integer
#

class Chapter < ApplicationRecord
  belongs_to :novel
  has_many :stories, dependent: :destroy

  def parent
  end
end
