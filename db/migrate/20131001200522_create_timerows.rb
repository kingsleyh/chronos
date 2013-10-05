class CreateTimerows < ActiveRecord::Migration
  def change
    create_table :timerows do |t|
      t.integer :timesheet_id
      t.string :task_name
      t.integer :task_id
      t.float :monday, :default => 0.0
      t.float :tuesday, :default => 0.0
      t.float :wednesday, :default => 0.0
      t.float :thursday, :default => 0.0
      t.float :friday, :default => 0.0
      t.float :saturday, :default => 0.0
      t.float :sunday, :default => 0.0
      t.float :total, :default => 0.0
      t.timestamps
    end
  end
end
