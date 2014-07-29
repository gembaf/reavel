# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :volume do
    part_id 1
    title "MyString"
    comment "MyString"
    serial 1
    time 1
    episode 1
    is_active false
  end
end
