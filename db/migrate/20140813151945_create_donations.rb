class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.references :user, index: true
      t.references :semester, index: true
      t.decimal :amt, precision: 6, scale: 2

      t.timestamps
    end
  end
end
