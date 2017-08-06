class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.timestamps
    end
  end

  create_table :branches_frames, id: false do |t|
    t.belongs_to :frame, index: true
    t.belongs_to :branch, index: true
  end
end
