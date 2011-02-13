class CreateNewsVideos < ActiveRecord::Migration
  def self.up
    create_table :news_videos do |t|
      t.string :title
      t.string :ante_title
      t.text   :description
      t.string :video_url
  
      t.timestamps
    end

    add_column :news_entries, :news_video_id, :integer
  end

  def self.down
    remove_column :news_entries, :news_video_id
    drop_table :news_videos
  end
end
