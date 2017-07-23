class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.references :cee, foreign_key: true
      t.datetime :date
      t.text :text
    end
  end
end
