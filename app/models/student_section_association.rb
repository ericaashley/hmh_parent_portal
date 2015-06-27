class StudentSectionAssociation < ActiveRecord::Base
  belongs_to :student
  belongs_to :section

  validates :student_id, presence: true
  validates :section_id, presence: true
  validates :ref_id, presence: true
end
