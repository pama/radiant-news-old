class NewsVideo < ActiveRecord::Base
  has_many :news_entries

  validates_presence_of  :title
end
