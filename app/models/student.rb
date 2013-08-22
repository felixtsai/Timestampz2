# == Schema Information
#
# Table name: students
#
#  id               :integer          not null, primary key
#  first_name       :string(255)      not null
#  last_name        :string(255)      not null
#  school           :string(255)      not null
#  grade_level      :string(255)      not null
#  homeroom_teacher :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Student < ActiveRecord::Base
  attr_accessible :grade_level, :homeroom_teacher, :first_name, :last_name

  has_many :student_groups
  has_many :groups, through: :student_groups
  has_many :student_assignments
  has_many :assignments, through: :student_assignments
  has_many :student_day_classes
  has_many :day_classes, through: :student_day_classes
  belongs_to :school

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :grade_level

  scope :by_last_name, order("last_name")

  def name
    self.first_name + ' ' + self.last_name
  end

  def incomplete_percentage
    (student_assignments.incomplete.count.to_f / student_assignments.count.to_f) * 100
  end

  def complete_percentage
    100 - incomplete_percentage
  end

end
