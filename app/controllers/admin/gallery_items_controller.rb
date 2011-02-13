class Admin::GalleryItemsController <  Admin::ResourceController
  def index
    @gallery_items = GalleryItem.paginate :page => params[:page], :per_page => 10
    @galleries = Gallery.find(:all, :order => 'name')
  end
end
