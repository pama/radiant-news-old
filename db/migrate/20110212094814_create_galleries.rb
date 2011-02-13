class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.string :name

      t.timestamps
    end

    add_column :news_entries, :gallery_id, :integer
  end

  def self.down
    remove_column :news_entries, :gallery_id
    drop_table :galleries
  end
end

