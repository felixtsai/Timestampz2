class StudentAssignmentsController < ApplicationController

  def edit
    @s_a = StudentAssignment.find(params[:id])
  end

  def update
    @s_a = StudentAssignment.find(params[:id])
    if @s_a.update_attributes(params[:student_assignment])
      flash[:success] = "Assignment successfully updated."
      redirect_to student_path(@s_a.student)
    else
      flash[:error] = @s_a.errors
      render :edit
    end
  end

  def destroy
  end

end
