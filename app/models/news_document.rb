class NewsDocument < ActiveRecord::Base
  has_attached_file :document, 
                    :url => "/media/news/document/:attachment/:id/:style_:basename.:extension"
  
  validates_presence_of  :title
  validates_presence_of  :description
end
