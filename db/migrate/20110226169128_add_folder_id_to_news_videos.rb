class AddFolderIdToNewsVideos < ActiveRecord::Migration
  def self.up
    add_column :news_videos, :news_folder_id, :integer
  end

  def self.down
    remove_column :news_videos, :news_folder_id
  end
end