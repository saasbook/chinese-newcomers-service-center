class AddAttachmentDocument3ToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :document3
    end
  end

  def self.down
    remove_attachment :items, :document3
  end
end
