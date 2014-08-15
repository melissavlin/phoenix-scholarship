class AddFieldnameToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :paid, :boolean, default: false
  end
end
