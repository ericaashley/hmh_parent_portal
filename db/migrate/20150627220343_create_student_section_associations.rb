class CreateStudentSectionAssociations < ActiveRecord::Migration
  def change
    create_table :student_section_associations do |t|
      t.integer :student_id, null: false
      t.integer :section_id, null: false
      t.string :ref_id, null: false
      t.string :student_ref_id
      t.string :section_ref_id
      t.string :school_year
      t.string :exit_date
    end
  end
end
