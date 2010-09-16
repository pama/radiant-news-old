class ChangeLeadtextFromStringToText < ActiveRecord::Migration
  def self.up
    change_column :news_entries, :leadtext, :text
  end

  def self.down
    # you will loose data.
    change_column :news_entries, :leadtext, :string
  end
end
