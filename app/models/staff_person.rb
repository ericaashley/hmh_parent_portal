class StaffPerson < ActiveRecord::Base
  has_many :staff_section_associations
  has_many :sections, through: :staff_section_associations
  has_many :assignments

  validates :user_name, presence: true
  validates :ref_id, presence: true
  validates :id_value, presence: true
  validates :given_name, presence: true
  validates :family_name, presence: true
  validates :phone_number, presence: true
  validates :email_address, presence: true
end
