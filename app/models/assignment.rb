# == Schema Information
#
# Table name: assignments
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  due_date     :date             not null
#  day_class_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Assignment < ActiveRecord::Base
  attr_accessible :due_date, :name, :day_class_id

  after_create :create_student_assignments

  has_many :student_assignments
  has_many :students, through: :student_assignments
  belongs_to :day_class

  validates_presence_of(:name)
  validates_presence_of(:due_date)
  validates_presence_of(:day_class)

  scope :past_due, -> { where(["due_date < ?", Date.today]) }

  private

  def create_student_assignments
    students = Student.joins(:student_day_classes).where('student_day_classes.day_class_id' => self.day_class_id)
    students.each do |student|
      StudentAssignment.create(assignment_id: self.id, student_id: student.id)
    end
  end
end
