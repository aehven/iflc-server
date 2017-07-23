class ExpandUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :integer, default: 1000
    add_column :users, :phone, :string
    add_column :users, :address, :string
  end
end
