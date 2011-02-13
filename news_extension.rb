# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class NewsExtension < Radiant::Extension
  version "1.0"
  description "Extension for news administration"
  url "http://github.com/pama/radiant-news-extension"
  
  def activate
    admin.nav << Radiant::AdminUI::NavTab.new("News")
    tab I18n.t('news_header') do # 'News' do
      add_item I18n.t('news_entries'), "/admin/news/news_entries"
      add_item I18n.t('news_categories'), "/admin/news/news_categories"
      add_item I18n.t("news_tags"), "/admin/news/news_tags"
      add_item I18n.t("news_galleries"), "/admin/news/galleries"
      add_item I18n.t("news_gallery_images"), "/admin/news/gallery_items"
      add_item I18n.t("news_videos"), "/admin/news/news_videos"
    end

    Page.send :include, NewsTags
  end
  
end
