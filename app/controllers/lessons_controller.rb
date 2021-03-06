class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :if_not_enrolled, :only => [:show]
	
	def show
	end

	private
	helper_method :current_lesson 
	def current_lesson 
		@current_lesson ||= Lesson.find(params[:id])
	end


	def if_not_enrolled
		unless current_user.enrolled_in?(current_lesson.section.course)
			redirect_to course_path(current_lesson.section.course), alert: "You are not enrolled."
		end
	end
end
