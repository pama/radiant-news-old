class Admin::GalleriesController <  Admin::ResourceController
  def index
    @galleries = Gallery.paginate :page => params[:page], :per_page => 10
  end
end