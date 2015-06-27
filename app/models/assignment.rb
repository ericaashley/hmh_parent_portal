class Assignment < ActiveRecord::Base
  has_many :assignment_submissions
  has_many :students, through: :assignment_submissions
  belongs_to :section

  validates :section_ref_id, presence: true
end
