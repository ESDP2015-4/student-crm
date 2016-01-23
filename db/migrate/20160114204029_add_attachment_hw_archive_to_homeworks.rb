class AddAttachmentHwArchiveToHomeworks < ActiveRecord::Migration
  def self.up
    change_table :homeworks do |t|
      t.attachment :hw_archive
    end
  end

  def self.down
    remove_attachment :homeworks, :hw_archive
  end
end
