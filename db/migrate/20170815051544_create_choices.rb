class CreateChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :choices do |t|
      t.string :text
      t.references :question, index: true

      t.timestamps
    end
  end
end
