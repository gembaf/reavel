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

FactoryBot.define do
  factory :chapter do
    title { 'タイトル' }
    comment { 'コメント' }
    no { 1 }
    novel
    parent_id { 0 }

    trait :top do
      parent_id { 0 }
    end
  end
end
