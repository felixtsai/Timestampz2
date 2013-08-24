class SchoolsController < ApplicationController
  before_action :setup, only: [:show, :edit, :update, :destroy]

  def new
    @school = School.new
  end

  def create
    @school = School.new(params[:school])
    if @school.save
      flash[:success] = "School successfully created!"
      redirect_to new_school_teacher_path(@school)
    else
      render :new
    end
  end

  def index
    @schools = School.by_name
  end

  def show
    @school = School.find(params[:id])
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    if @school.update_attributes(params[:school])
      flash[:success] = 'School successfully updated'
      redirect_to schools_path
    else
      render 'edit'
    end
  end

  def destroy
    @school = School.find(params[:id])
    @school.destroy
    redirect_to schools_path
  end

  private

  def setup
    @school = School.find(params[:id])
  end
end
