class StudentsController < ApplicationController
  
	def index
		@group = Group.find(params[:group_id])
		@students = @group.students
	end

	def show
  	@student = Student.find(params[:id])
		@assignments = @student.student_assignments.order("completion_date DESC")
	end

  def new
  end

end
