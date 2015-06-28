class SectionsController < ApplicationController
	def index
		@sections = StaffPerson.find_by(email_address: current_user.email).sections
	end
end
