class AddReferencedByToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :referrer, :integer
    add_column :contacts, :ma, :string
  end
end
