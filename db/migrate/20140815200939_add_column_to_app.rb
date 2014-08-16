class AddColumnToApp < ActiveRecord::Migration
  def change
    add_column :apps, :open, :boolean, default: true
  end
end
