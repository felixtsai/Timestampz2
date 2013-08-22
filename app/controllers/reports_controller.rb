class ReportsController < ApplicationController

	def student
		@student = Student.find(params[:id])
		@assignments = @student.student_assignments.order("completion_date DESC")
	end

end
