class SectionsController < ApplicationController
	def index
		if current_user.role == "Teacher"
			@sections = StaffPerson.find_by(email_address: current_user.email).sections
		elsif current_user.role == "Parent"
			@student = Student.find_by(parent_id: current_user.id)
			@sections = @student.sections
		end
	end
end
