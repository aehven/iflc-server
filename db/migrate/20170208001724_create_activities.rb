class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :account, foreign_key: true
      t.datetime :date
      t.text :text
    end
  end
end
