class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :code
      t.text :description
      t.integer :project_id
      t.boolean :active
      t.decimal :duration
      t.boolean :billable
      t.timestamps
    end
  end
end
