class StudentsController < ApplicationController
	def index
		@section = Section.find(params[:section_id])
		@students = @section.students
	end
end
