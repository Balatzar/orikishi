class AddActiveToSurvey < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :active, :boolean
  end
end
