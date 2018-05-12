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

FactoryBot.define do
  factory :novel do
    title { 'タイトル' }
    summary { '概要' }
  end
end
