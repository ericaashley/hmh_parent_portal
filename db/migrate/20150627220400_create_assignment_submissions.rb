class CreateAssignmentSubmissions < ActiveRecord::Migration
  def change
    create_table :assignment_submissions do |t|
      t.integer :student_id, null: false
      t.integer :assignment_id, null: false
      t.string :ref_id, null: false
      t.string :student_ref_id
      t.string :assignment_ref_id
      t.decimal :score
      t.string :status
    end
  end
end
