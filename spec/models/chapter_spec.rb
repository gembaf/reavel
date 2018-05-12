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

require 'rails_helper'

RSpec.describe Chapter, type: :model do
  describe 'relations' do
    it { should belong_to(:novel) }
    it { should have_many(:stories).dependent(:destroy) }
  end

  describe '#parent' do
    subject { chapter.parent }

    let(:chapter) { create(:chapter, parent_id: parent.id) }
  end
end
