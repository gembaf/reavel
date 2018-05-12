# == Schema Information
#
# Table name: novels
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  summary    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Novel, type: :model do
  describe 'relations' do
    it { should have_many(:chapters).dependent(:destroy) }
  end
end
