# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    novel_id 1
    title "MyString"
    contents "MyString"
    is_active false
  end
end
