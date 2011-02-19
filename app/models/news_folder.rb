class NewsFolder < ActiveRecord::Base
  has_many :gallery_items
end
