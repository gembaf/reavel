# == Schema Information
#
# Table name: stories
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  comment    :string(255)
#  no         :integer          not null
#  time       :integer          default(0), not null
#  uuid       :string(255)      not null
#  is_scene   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chapter_id :integer          not null
#

require 'kconv'

class Story < ApplicationRecord
  before_destroy :delete_text

  belongs_to :chapter

  DATA_DIR = Rails.root.join('public', 'data', 'stories')
  READ_PER_MINUTES = 1000

  def filepath
    "#{DATA_DIR}/#{uuid}.txt"
  end

  def write(text)
    File.write(filepath, text.toutf8)
  end

  def read
    File.read(filepath)
  end

  def brothers
    Story.where(chapter_id: chapter_id)
  end

  def next
    next_story = brothers.find_by(no: no + 1)
    return next_story if next_story

    return nil unless chapter&.next&.stories.present?
    chapter.next.stories.first
  end

  def prev
    prev_story = brothers.find_by(no: no - 1)
    return prev_story if prev_story

    return nil unless chapter&.prev&.stories.present?
    chapter.prev.stories.last
  end

  def delete_text
    FileUtils.rm(filepath)
  end

  def self.required_time(text)
    text.length / READ_PER_MINUTES
  end
end
