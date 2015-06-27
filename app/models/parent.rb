class Parent < ActiveRecord::Base
  has_many :students

  validates :user_name, presence: true
  validates :given_name, presence: true
  validates :family_name, presence: true
end
