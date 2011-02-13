class NewsEntry < ActiveRecord::Base
  has_and_belongs_to_many :news_categories , :join_table => 'news_entries_news_categories'
  has_and_belongs_to_many :news_tags , :join_table => 'news_entries_news_tags'

  has_attached_file :photo_text, :url => "/media/news/:attachment/:id/:style_:basename.:extension"
  has_attached_file :photo_lead, :url => "/media/news/:attachment/:id/:style_:basename.:extension"
  belongs_to             :gallery

  validates_presence_of  :headline
  validates_presence_of  :leadtext
  validates_presence_of  :start

  def before_save
    uncategorized_tag = NewsCategory.find_by_name('uncategorized')
    NewsCategory.new(:name => 'uncategorized').save! unless uncategorized_tag
    self.news_categories = [uncategorized_tag || NewsCategory.find_by_name('uncategorized')] if self.news_categories == []
  end
end
