class AddAttachmentToImage < ActiveRecord::Migration
  def up
    add_attachment :assets, :image
  end

  def down
    remove_attachment :assets, :image
  end
end
