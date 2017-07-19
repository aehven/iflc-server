class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :phone
      t.string :fax
      t.string :email
      t.string :website
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.integer :kind
      t.string :om
      t.string :fd1
      t.string :fd2
      t.string :rc
    end
  end
end
