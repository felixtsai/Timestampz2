class AssignmentsController < ApplicationController

	def index
		@assignments = Assignment.all
	end

	def new
		@assignment = Assignment.new
		@day_classes = DayClass.all.map{|c| [c.subject, c.id] }
	end

	def create
		@assignment = Assignment.new(params[:assignment])
		@assignment.day_class_id = params[:assignment][:day_class_id]
		if @assignment.save
			redirect_to assignments_path
		else
			redirect_to new_assignment_path
		end
	end

	def edit
		@assignment = Assignment.find(params[:id])
		@day_classes = DayClass.all.map{|c| [c.subject, c.id] }
	end

	def update
		@assignment = Assignment.find(params[:id])
		if @assignment.update_attributes(params[:assignment])
			redirect_to assignments_path
		else
			flash[:error] = @assignment.errors
			render :edit
		end
	end

	def destroy
		@assignment = Assignment.find(params[:id])
		@assignment.delete
		redirect_to assignments_path
	end
end