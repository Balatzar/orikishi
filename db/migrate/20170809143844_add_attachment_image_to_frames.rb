class AddAttachmentImageToFrames < ActiveRecord::Migration[5.1]
  def self.up
    change_table :frames do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :frames, :image
  end
end
