class AddDaysInOfficeToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :sunday, :boolean
    add_column :contacts, :monday, :boolean
    add_column :contacts, :tuesday, :boolean
    add_column :contacts, :wednesday, :boolean
    add_column :contacts, :thursday, :boolean
    add_column :contacts, :friday, :boolean
    add_column :contacts, :saturday, :boolean
  end
end
