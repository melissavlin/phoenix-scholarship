class AddFieldnameToApp < ActiveRecord::Migration
  def change
    add_column :apps, :vote_count, :integer
    add_column :apps, :semester, :string
    add_column :apps, :award, :boolean
    add_column :users, :has_voted, :boolean, default: false
  end
end
