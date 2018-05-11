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
#

class Story < ApplicationRecord
  DATA_DIR = Rails.root.join('public', 'data', 'stories')

  def filepath
    "#{DATA_DIR}/#{uuid}.txt"
  end

  def write(text)
    File.write(filepath, text)
  end

  def read
    File.read(filepath)
  end
end
