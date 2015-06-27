class CreateStaffPeople < ActiveRecord::Migration
  def change
    create_table :staff_people do |t|
      t.string :user_name
      t.string :ref_id
      t.string :id_value
      t.string :given_name
      t.string :family_name
      t.string :phone_number
      t.string :email_address
    end
  end
end
