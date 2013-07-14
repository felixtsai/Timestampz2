# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    name "Group 1"
    teacher_first_name "Felix"
    teacher_last_name "Tsai"
  end

  factory :assignment do
  	name "Assignment 1"
  	due_date Time.now + 2.days
  	association :day_class
  end

  factory :day_class do
  	teacher "Felix"
  	period "4"
  	school "Middle" 
  	subject "Math"
  end

  factory :user do
    email "fake_email@gmail.com"
    password 'password'
    password_confirmation 'password'
  end

end
