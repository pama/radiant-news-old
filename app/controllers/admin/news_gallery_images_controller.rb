class Admin::NewsGalleryImagesController <  Admin::ResourceController    
  def create
    @galleries = NewsFolder.find(:all, :conditions => "type_id = 2", :order => "name")
    super    
  end
  
  def index
    @news_gallery_images = NewsGalleryImage.paginate :page => params[:page], :per_page => 10, :include => :news_folder, :conditions => "news_folders.type_id = 2"    
  end 
  
  def edit
    @galleries = NewsFolder.find(:all, :conditions => "type_id = 2", :order => "name")
    super    
  end  
  
  def new
    @galleries = NewsFolder.find(:all, :conditions => "type_id = 2", :order => "name")
    super    
  end
    
end
