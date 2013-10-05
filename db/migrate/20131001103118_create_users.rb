class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :authorised_tasks
      t.text :default_task
      t.boolean :active, :default => true
      t.boolean :admin, :default => false
      t.timestamps
    end
  end
end
