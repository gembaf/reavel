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
#  parent_id  :integer          default(0), not null
#

class Chapter < ApplicationRecord
  belongs_to :novel
  has_many :stories, dependent: :destroy

  def parent
    return nil if top?
    Chapter.find(parent_id)
  end

  def children
    chapters = Chapter.where(parent_id: id).order(:no)
    chapters.present? ? chapters : []
  end

  def brothers
    Chapter.where(novel_id: novel_id, parent_id: parent_id)
  end

  def next
    next_chapter = brothers.find_by(no: no + 1)
    return next_chapter if next_chapter.present?

    return nil unless parent&.next&.children.present?
    parent.next.children.first
  end

  def prev
    prev_chapter = brothers.find_by(no: no - 1)
    return prev_chapter if prev_chapter.present?

    return nil unless parent&.prev&.children.present?
    parent.prev.children.last
  end

  def top?
    parent_id == 0
  end
end
