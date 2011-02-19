ActionController::Routing::Routes.draw do |map|
  map.namespace :admin, :member => { :remove => :get } do |admin|
    admin.resources :news_categories, :path_prefix => '/admin/news'
    admin.resources :news_documents, :path_prefix => '/admin/news'
    admin.resources :news_entries, :path_prefix => '/admin/news'
    admin.resources :news_folders, :path_prefix => '/admin/news'
    admin.resources :news_gallery_images, :path_prefix => '/admin/news'
    admin.resources :news_tags, :path_prefix => '/admin/news'    
    admin.resources :news_videos, :path_prefix => '/admin/news'        
  end

  #map.with_options(:controller => 'admin/news/news_tags') do |b|
  #  b.toggle    '/admin/news/news_categories/toggle/:id', :action => 'toggle'
  #end
end
