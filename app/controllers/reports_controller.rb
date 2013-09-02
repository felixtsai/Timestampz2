class ReportsController < ApplicationController

	def index
		@groups = Group.all
		@grades = ["6", "7", "8"]
	end

	def show
		if params[:category] == 'group'
			@groups = Group.all
		elsif params[:category] == 'grade'
			@grades = ["6", "7", "8"]
		end
	end

end
