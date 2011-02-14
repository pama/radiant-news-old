ActionController::Routing::Routes.draw do |map|
  map.namespace :admin, :member => { :remove => :get } do |admin|
    admin.resources :galleries, :path_prefix => '/admin/news'
    admin.resources :gallery_items, :path_prefix => '/admin/news'
    admin.resources :news_entries, :path_prefix => '/admin/news'
    admin.resources :news_tags, :path_prefix => '/admin/news'
    admin.resources :news_categories, :path_prefix => '/admin/news'
    admin.resources :news_videos, :path_prefix => '/admin/news'
  end

  map.with_options(:controller => 'admin/news/news_tags') do |b|
    b.toggle    '/admin/news/news_categories/toggle/:id', :action => 'toggle'
  end
end
