class App < ActiveRecord::Base
  belongs_to :user
  belongs_to :semester
end
