# == Schema Information
#
# Table name: student_assignments
#
#  id              :integer          not null, primary key
#  student_id      :integer
#  assignment_id   :integer
#  completion_date :datetime
#  comment         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class StudentAssignment < ActiveRecord::Base
  attr_accessible :assignment_id, :completed, :student_id

  belongs_to :student
  belongs_to :assignment

  scope :incomplete , -> { where(completion_date: nil) }

  scope :past_due, -> { where('assignment_id in (SELECT id FROM assignments
    WHERE due_date < ?)', Date.today) }

  scope :today, -> { where("created_at < ? AND created_at > ?", Date.tomorrow, Date.yesterday)}

end
