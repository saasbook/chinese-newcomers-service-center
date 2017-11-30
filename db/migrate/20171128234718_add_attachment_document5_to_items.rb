class AddAttachmentDocument5ToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :document5
    end
  end

  def self.down
    remove_attachment :items, :document5
  end
end
