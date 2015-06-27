class StaffSectionAssociation < ActiveRecord::Base
  belongs_to :section
  belongs_to :staff_person

  validates :ref_id, presence: true
end
