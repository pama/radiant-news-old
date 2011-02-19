class CreateNewsDocuments < ActiveRecord::Migration
  def self.up
    create_table :news_documents do |t|
      t.string  :title
      t.string  :date
      t.text    :description
      t.string  :authors
      t.integer :news_folder_id
      
      t.string  :document_file_name
      t.string  :document_content_type
      t.integer :document_file_size

      t.timestamps
    end
    
    add_column :news_entries, :news_document_id, :integer
  end

  def self.down
    remove_column :news_entries, :news_document_id
    drop_table :news_documents
  end
end

