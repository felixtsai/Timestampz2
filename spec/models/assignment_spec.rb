require 'spec_helper'

describe Assignment do

  it { should have_many :student_assignments }
  it { should have_many :students }
  it { should belong_to :day_class }

  it { should validate_presence_of :name }
  it { should validate_presence_of :due_date }
  it { should validate_presence_of :day_class }

  let(:day_class) { FactoryGirl.create(:day_class) }
  let(:assignment) { FactoryGirl.build(:assignment, day_class_id: day_class.id) }
  let(:student_1) { FactoryGirl.create(:student) }
  let(:student_2) { FactoryGirl.create(:student, last_name: "Smith", first_name: "John", grade_level: "6th") }
  let(:sdc1) { FactoryGirl.create(:student_day_class, student_id: student_1.id, day_class_id: day_class.id) }
  let(:sdc2) { FactoryGirl.create(:student_day_class, student_id: student_1.id, day_class_id: 10) }

  describe 'after_create' do
    before :each do
      sdc1; sdc2
    end

    it 'creates student_assignments for students in the class' do
      expect{assignment.save}.to change{student_1.student_assignments.count}.by(1)
    end

    it 'does not creates student_assignments for students not in the class' do
      expect{assignment.save}.to_not change{student_2.student_assignments.count}.by(1)
    end
  end
end
