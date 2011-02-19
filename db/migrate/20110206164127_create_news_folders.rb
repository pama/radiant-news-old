class CreateNewsFolders < ActiveRecord::Migration
  def self.up
    create_table :news_folders do |t|
      t.string  :name
      t.integer :type_id
      t.string  :type_name

      t.timestamps
    end
  end

  def self.down    
    drop_table :news_folders
  end
end
