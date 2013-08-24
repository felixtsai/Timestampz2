# == Schema Information
#
# Table name: student_day_classes
#
#  id           :integer          not null, primary key
#  student_id   :integer
#  day_class_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class StudentDayClass < ActiveRecord::Base
  attr_accessible :day_class_id, :student_id, :id

  after_save :create_student_assignments

  belongs_to :students
  belongs_to :day_class

  delegate :period, to: :day_class

  private

  def create_student_assignments
    Assignment.find_all_by_day_class_id(self.day_class_id).each do |assignment|
      if assignment.due_date >= Time.zone.now.to_date
        StudentAssignment.create(student_id: self.student_id, assignment_id: assignment.id)
      end
    end
  end
end
