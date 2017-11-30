class AddAttachmentDocument1ToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :document1
    end
  end

  def self.down
    remove_attachment :items, :document1
  end
end
