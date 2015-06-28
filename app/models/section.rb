class Section < ActiveRecord::Base
  has_many :student_section_associations
  has_many :students, through: :student_section_associations
  has_many :staff_section_associations
  has_many :staff_persons, through: :staff_section_associations
  has_many :assignments
  validates :status, presence: true
  validates :school_year, presence: true
  validates :ref_id, presence: true
  validates :name, presence: true
end
