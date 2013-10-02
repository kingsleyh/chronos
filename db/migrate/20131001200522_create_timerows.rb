class CreateTimerows < ActiveRecord::Migration
  def change
    create_table :timerows do |t|
      t.integer :timesheet_id
      t.string :task_name
      t.float :monday
      t.float :tuesday
      t.float :wednesday
      t.float :thursday
      t.float :friday
      t.float :saturday
      t.float :sunday
      t.float :total
      t.timestamps
    end
  end
end
