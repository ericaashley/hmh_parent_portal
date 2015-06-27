class AssignmentSubmission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :student

  validates :ref_id, presence: true
end
