class AssignmentsController < ApplicationController
  def index
    @section = Section.find(params[:section_id])
    @assignments = @section.assignments
  end
end
