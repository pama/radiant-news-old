# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class NewsExtension < Radiant::Extension
  version "1.0"
  description "Extension for news administration"
  url "http://github.com/pama/radiant-news-extension"
  
  define_routes do |map|
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :news_entries
      admin.resources :news_tags
      admin.resources :news_categories
    end
  end
  
  def activate
    tab 'Content' do
      add_item "News", "/admin/news_entries", :after => "Pages", :visibility => [:all]
    end

    Page.send :include, NewsTags
  end
  
end
