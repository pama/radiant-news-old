ActionController::Routing::Routes.draw do |map|
  map.namespace :admin, :member => { :remove => :get } do |admin|
    admin.resources :news_entries, :path_prefix => '/admin/news'
    admin.resources :news_tags, :path_prefix => '/admin/news'
    admin.resources :news_categories, :path_prefix => '/admin/news'
  end
end
