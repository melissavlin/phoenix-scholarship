class CreateSemesters < ActiveRecord::Migration
  def change

    create_table :semesters do |t|
      t.date :year
      t.integer :season
      t.date :app_deadline
      t.date :vote_deadline

      t.timestamps
    end
  end
end
