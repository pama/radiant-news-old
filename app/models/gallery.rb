class Gallery < ActiveRecord::Base
  has_many :news_entry
  has_many :gallery_items, :dependent => :delete_all

  validates_presence_of  :name
end
