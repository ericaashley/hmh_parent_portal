class CreateStaffSectionAssociations < ActiveRecord::Migration
  def change
    create_table :staff_section_associations do |t|
      t.integer :staff_person_id
      t.integer :section_id
      t.string :ref_id, null: false
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
