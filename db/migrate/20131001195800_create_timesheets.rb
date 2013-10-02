class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.datetime :week_commencing
      t.timestamps
    end
  end
end
