ActionController::Routing::Routes.draw do |map|
  map.namespace :admin, :member => { :remove => :get } do |admin|
    admin.resources :news_entries
    admin.resources :news_tags
    admin.resources :news_categories
  end
end
