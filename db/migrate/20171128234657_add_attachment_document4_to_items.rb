class AddAttachmentDocument4ToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :document4
    end
  end

  def self.down
    remove_attachment :items, :document4
  end
end
