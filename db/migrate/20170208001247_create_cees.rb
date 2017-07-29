class CreateCees < ActiveRecord::Migration[5.0]
  def change
    create_table :cees do |t|
      t.string :name
      t.integer :state
      t.integer :source
    end
  end
end
