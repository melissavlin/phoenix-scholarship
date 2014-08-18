class AddColumnsToApp < ActiveRecord::Migration
  def change
  	add_column :apps, :semester_active, :integer
  	add_column :apps, :semester_id, :integer
  	add_column :apps, :semester_inactive, :text
  	add_column :apps, :major, :string
  	add_column :apps, :minor, :string
  	add_column :apps, :credit_count, :integer
  	add_column :apps, :academic_probation, :string
  	add_column :apps, :post_grad_goal, :text
  	add_column :apps, :position_accomplishment, :text
  	add_column :apps, :sis_event_planning, :text
  	add_column :apps, :org_improvement, :text
  	add_column :apps, :com_service_attended, :text
  	add_column :apps, :com_service_planning, :text
  	add_column :apps, :other_org_membership, :text
  	add_column :apps, :workshop_attended, :text
  	add_column :apps, :workshop_planning, :text
  	add_column :apps, :cv, :text
  end
end
