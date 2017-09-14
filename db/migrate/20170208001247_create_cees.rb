class CreateCees < ActiveRecord::Migration[5.0]
  def change
    create_table :cees do |t|
      t.string :name
      t.integer :state
      t.boolean :animal
      t.boolean :vegetable
      t.boolean :mineral
      t.binary :image, limit: 10.megabytes
    end
  end
end
