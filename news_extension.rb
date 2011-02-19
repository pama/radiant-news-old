# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class NewsExtension < Radiant::Extension
  version "1.0"
  description "Extension for news administration"
  url "http://github.com/pama/radiant-news-extension"
  
  def activate
    admin.nav << Radiant::AdminUI::NavTab.new("News")
    tab I18n.t('news.menu.header') do # 'News' do
      add_item I18n.t('news.menu.entries'), "/admin/news/news_entries"
      add_item I18n.t('news.menu.categories'), "/admin/news/news_categories"
      add_item I18n.t("news.menu.tags"), "/admin/news/news_tags"
      add_item I18n.t("news.menu.folders"), "/admin/news/news_folders"      
      add_item I18n.t("news.menu.gallery"), "/admin/news/news_gallery_images"            
      add_item I18n.t("news.menu.documents"), "/admin/news/news_documents"            
      add_item I18n.t("news.menu.videos"), "/admin/news/news_videos"      
    end

    Page.send :include, NewsTags
  end
  
end
