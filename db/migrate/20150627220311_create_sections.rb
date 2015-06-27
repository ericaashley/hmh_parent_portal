class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :status, null: false
      t.string :school_year, null: false
      t.string :ref_id, null: false
      t.string :name, null: false
    end
  end
end
