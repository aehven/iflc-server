class ExpandUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :integer, default: 1000
    add_column :users, :phone, :string
    add_column :users, :address, :string
    # this isn't necessary if open maps in new tab with address query
    # add_column :users, :latitude, :float
    # add_column :users, :longitude, :float
  end
end
