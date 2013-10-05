class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.datetime :week_commencing
      t.string :status, :default => 'new'
      t.integer :user_id
      t.timestamps
    end
  end
end
