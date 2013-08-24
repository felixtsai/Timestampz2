class StudentsController < ApplicationController
  def index
    @students = Student.by_last_name
  end

  def show
    @student = Student.find(params[:id])
    @student_assignments = @student.student_assignments.order("completion_date DESC")
  end

  def new
    @student = Student.new
    @groups = Group.all
    @schools = School.by_name
    @day_classes_1 = DayClass.period_one
    @day_classes_2 = DayClass.period_two
    @day_classes_3 = DayClass.period_three
    @student.student_groups.build
    @student.student_day_classes.build
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      flash[:success] = "Student successfully created!"
      redirect_to new_student_path
    else
      flash[:error] = "Errors. Please try again."
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
    @groups = Group.all
    @schools = School.by_name
    @day_classes_1 = DayClass.period_one
    @day_classes_2 = DayClass.period_two
    @day_classes_3 = DayClass.period_three
    @student_day_class_1 = @student.student_day_classes.joins(:day_class).where(day_classes: { period: "1st"}).first
    @student_day_class_2 = @student.student_day_classes.joins(:day_class).where(day_classes: { period: "2nd"}).first
    @student_day_class_3 = @student.student_day_classes.joins(:day_class).where(day_classes: { period: "3rd"}).first
  end


  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:success] = "Student successfully updated."
      redirect_to students_path
    else
      flash[:error] = @student.errors
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.delete
    redirect_to students_path
  end

  def assignments
    @student = Student.find(params[:id])
    @student_assignments = @student.student_assignments
  end
end
