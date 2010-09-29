class AddPhotoToNewsEntry < ActiveRecord::Migration
  def self.up
    add_column :news_entries, :photo_lead_file_name, :string
    add_column :news_entries, :photo_lead_content_type, :string
    add_column :news_entries, :photo_lead_file_size, :integer
    add_column :news_entries, :photo_text_file_name, :string
    add_column :news_entries, :photo_text_content_type, :string
    add_column :news_entries, :photo_text_file_size, :integer
    add_column :news_entries, :photo_text_caption, :string, :default => ""
  end

  def self.down
    remove_column :news_entries, :photo_lead_file_name
    remove_column :news_entries, :photo_lead_content_type
    remove_column :news_entries, :photo_text_lead_file_size
    remove_column :news_entries, :photo_text_file_name
    remove_column :news_entries, :photo_text_content_type
    remove_column :news_entries, :photo_text_file_size
    remove_column :news_entries, :photo_text_caption
  end
end
