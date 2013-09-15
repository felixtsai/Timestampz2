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
  attr_accessible :grade_level, :homeroom_teacher, :first_name, :last_name, :school_id,
                    :student_groups_attributes, :student_day_classes_attributes

  has_many :student_groups, dependent: :destroy
  has_many :groups, through: :student_groups
  has_many :student_assignments, dependent: :destroy
  has_many :assignments, through: :student_assignments
  has_many :student_day_classes, dependent: :destroy
  has_many :day_classes, through: :student_day_classes
  belongs_to :school

  accepts_nested_attributes_for :student_groups, :student_day_classes

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :grade_level

  scope :by_last_name, -> { order("last_name") }

  def name
    self.first_name + ' ' + self.last_name
  end

  def incomplete_percentage
    (student_assignments.incomplete.count.to_f / student_assignments.count.to_f) * 100
  end

  def complete_percentage
    100 - incomplete_percentage
  end

  def past_due_percentage
    (student_assignments.past_due.count.to_f / student_assignments.count.to_f) * 100
  end
end
