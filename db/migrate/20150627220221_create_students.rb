class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :user_name, null: false
      t.string :ref_id, null: false
      t.string :id_value, null: false
      t.string :given_name, null: false
      t.string :family_name, null: false
      t.string :phone_number
      t.string :email_address
      t.integer :parent_id
    end
  end
end
