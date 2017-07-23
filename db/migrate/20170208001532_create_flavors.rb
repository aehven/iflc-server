class CreateFlavors < ActiveRecord::Migration[5.0]
  def change
    create_table :flavors do |t|
      t.references :cee, foreign_key: true
      t.string :name
      t.string :color
    end
  end
end
