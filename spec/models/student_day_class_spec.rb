require 'spec_helper'

describe StudentDayClass do
  let(:student) { FactoryGirl.create(:student) }
  let(:day_class) { FactoryGirl.create(:day_class) }
  let(:assignment_1) { FactoryGirl.create(:assignment, day_class_id: day_class.id) }
  let(:assignment_2) { FactoryGirl.create(:assignment, name: "Assignment 2", due_date: Time.now - 2.days,
                                          day_class_id: day_class.id) }
  let(:student_day_class) { FactoryGirl.build(:student_day_class, student_id: student.id, day_class_id: day_class.id) }
  let(:new_day_class) { FactoryGirl.create(:day_class, period: '3rd', subject: "ELA") }
  let(:new_assignment) { FactoryGirl.create(:assignment, name: "Assignment 3", day_class_id: new_day_class.id) }

  describe 'after_create' do
    it 'adds student_assignments when a student chooses classes' do
      assignment_1
      expect{student_day_class.save}.to change{student.student_assignments.count}.by(1)
    end

    it 'does not add an expired assignment' do
      assignment_2
      expect{student_day_class.save}.to change{student.student_assignments.count}.by(0)
    end
  end

  describe 'after_update' do
    before :each do
      assignment_1; assignment_2; new_assignment
      student_day_class.save
    end

    it 'adds new student_assignments if class has changed' do
      expect{student_day_class.update_attributes(day_class_id: new_day_class.id)}.to change{student.student_assignments.count}.by(1)
    end

    it 'does not add new student_assignments if no change' do
      puts "day_class_id: #{day_class.id}"
      puts "new_day_class_id: #{new_day_class.id}"
      puts "assignment_1: #{assignment_1.inspect}"
      puts "new_assignment: #{new_assignment.inspect}"    
      puts "s-a: #{student.student_assignments.inspect}"
      expect{student_day_class.update_attributes(day_class_id: day_class.id)}.to change{student.student_assignments.count}.by(0)
      puts "s-a: #{student.student_assignments.inspect}"
      
    end
  end
end
