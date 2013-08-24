class Teacher < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :school_id

  has_many :day_classes
  belongs_to :school

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :school_id
end
