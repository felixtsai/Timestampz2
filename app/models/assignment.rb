# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  due_date   :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Assignment < ActiveRecord::Base
  attr_accessible :due_date, :name

  has_many :student_assignments
  has_many :students, through: :student_assignments
  belongs_to :day_class

  validates_presence_of(:name)
  validates_presence_of(:due_date)
  validates_presence_of(:day_class)
end
