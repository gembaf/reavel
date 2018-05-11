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

FactoryBot.define do
  factory :story do
    title { '無題' }
    comment { 'コメント' }
    no { 1 }
    time { 100 }
    uuid { 'hoge-foo-bar' }
    is_scene { false }
  end
end

