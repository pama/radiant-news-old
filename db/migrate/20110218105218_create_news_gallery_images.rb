class CreateNewsGalleryImages < ActiveRecord::Migration
  def self.up
    create_table :news_gallery_images do |t|
      t.string  :title
      t.string  :description
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size            
      t.string  :small_title
      t.string  :small_description
            
      t.integer :news_folder_id
      
      t.timestamps
    end
    
    add_column :news_entries, :news_gallery_image_id, :integer
  end

  def self.down
    remove_column :news_entries, :news_gallery_image_id
    drop_table :news_gallery_images
  end
end
