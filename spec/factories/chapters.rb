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

FactoryBot.define do
  factory :chapter do
    title { 'タイトル' }
    comment { 'コメント' }
    no { 1 }
    novel
    level { 1 }
    parent_id { 1 }
  end
end
