class StudentsController < ApplicationController
	def index
		@section = Section.find(params[:section_id])
		@students = @section.students
	end

	def show
		@student = Student.find(params[:id])
		@student_sections = @student.sections
		@assignment_submissions = @student.assignment_submissions
	end
end
