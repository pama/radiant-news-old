class AddAnteHeadlineToNewsEntry < ActiveRecord::Migration
  def self.up
    add_column :news_entries, :ante_headline, :string
  end

  def self.down
    remove_column :news_entries, :ante_headline
  end
end
