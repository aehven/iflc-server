class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.string :favoritable_type
      t.integer :favoritable_id
    end

    add_index :favorites, :favoritable_id
    add_index :favorites, :favoritable_type
    add_index :favorites, [:favoritable_id, :favoritable_type, :user_id], name: "unique_favorites", unique: true
  end
end
