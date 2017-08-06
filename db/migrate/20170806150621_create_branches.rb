class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.references :frame, index: true

      t.timestamps
    end
  end
end
