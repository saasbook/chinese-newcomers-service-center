class AddAttachmentDocument2ToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :document2
    end
  end

  def self.down
    remove_attachment :items, :document2
  end
end
