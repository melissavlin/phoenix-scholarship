class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.references :user, index: true
      t.float :gpa
      t.text :current_position
      t.text :past_position
      t.text :sis_events
      t.text :achievement

      t.timestamps
    end
  end
end
