# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class NewsExtension < Radiant::Extension
  version "1.0"
  description "Extension for news administration"
  url "http://github.com/pama/radiant-news-extension"
  
  def activate
    admin.nav << Radiant::AdminUI::NavTab.new("News")
    tab 'News' do
      add_item "News", "/admin/news/news_entries"
      add_item "Categories", "/admin/news/news_categories"
      add_item "Tags", "/admin/news/news_tags"
      add_item "Galleries", "/admin/news/galleries"
      add_item "GalleryItems", "/admin/news/gallery_items"
    end

    Page.send :include, NewsTags
  end
  
end
