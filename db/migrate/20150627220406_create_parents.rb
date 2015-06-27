class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :user_name, null: false
      t.string :given_name, null: false
      t.string :family_name, null: false
      t.string :phone_number
      t.string :email_address
    end
  end
end
