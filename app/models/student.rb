class Student < ActiveRecord::Base
  has_many :assignment_submissions
  has_many :assignments, through: :assignment_submissions
  has_many :student_section_associations
  has_many :sections, through: :student_section_associations
  belongs_to :parent

  validates :user_name, presence: true
  validates :ref_id, presence: true
  validates :id_value, presence: true
  validates :given_name, presence: true
  validates :family_name, presence: true
end
