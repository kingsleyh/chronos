class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :code
      t.text :description
      t.boolean :active
      t.timestamps
    end
  end
end
