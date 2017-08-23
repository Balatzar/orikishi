class CreateSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :surveys do |t|
      t.string :name
      t.boolean :random
      t.integer :time

      t.timestamps
    end
  end
end