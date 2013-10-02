class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :code
      t.text :description
      t.integer :customer_id
      t.boolean :active
      t.timestamps
    end
  end
end
