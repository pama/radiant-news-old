class CreateGalleryItems < ActiveRecord::Migration
  def self.up
    create_table :gallery_items do |t|
      t.string  :description
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size
      
      t.integer :gallery_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :gallery_items
  end
end