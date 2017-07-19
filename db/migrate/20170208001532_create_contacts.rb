class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.references :account, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :street
      t.string :city
      t.string :zip
      t.integer :kind
    end
  end
end
