class CreateFrames < ActiveRecord::Migration[5.1]
  def change
    create_table :frames do |t|
      t.string :text
      t.references :step, index: true

      t.timestamps
    end
  end
end
