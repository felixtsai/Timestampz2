# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    name "Assignment 1"
    due_date Time.now + 2.days
    association :day_class
  end

  factory :day_class do
    period "3rd"
    subject "Math"
    association :school, strategy: :build
    association :teacher, strategy: :build
  end

  factory :group do
    name "Group 1"
    teacher_first_name "Felix"
    teacher_last_name "Tsai"
  end

  factory :school do
    name "Sequoia"
  end

  factory :student do
    first_name "Betty"
    last_name "Rubble"
    grade_level "6th"
    association :school
  end

  factory :student_day_class do
    association :student, strategy: :build
    association :day_class, strategy: :build
  end

  factory :teacher do
    first_name "Fred"
    last_name "Flintstone"
    association :school
  end

  factory :user do
    email "fake_email@gmail.com"
    password 'password'
    password_confirmation 'password'
  end
end
