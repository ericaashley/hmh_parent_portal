class AssignmentSubmissionsController < ApplicationController
  def show
    @submission = AssignmentSubmission.find(params[:id])
    @student = @submission.student
    @assignment = @submission.assignment
    @section = @assignment.section
    @teacher = @assignment.staff_person
  end
end
