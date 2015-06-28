class SectionsController < ApplicationController
	def index
		# @staff_section_associations = StaffSectionAssociation.where(staff_person_id: current_user)
		@sections = StaffPerson.find_by(email_address: current_user.email).sections
	end
end
