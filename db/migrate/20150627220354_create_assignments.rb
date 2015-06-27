class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.jsonb :students
      t.string :section_ref_id, null: false
      t.integer :section_id
      t.string :status
      t.string :description
      t.string :name
      t.string :ref_id
      t.string :creator_ref_id
      t.integer :staff_person_id
      t.datetime :available_date
      t.datetime :due_date
    end
  end
end
