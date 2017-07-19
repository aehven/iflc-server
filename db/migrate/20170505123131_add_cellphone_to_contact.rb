class AddCellphoneToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :cellphone, :string
  end
end
