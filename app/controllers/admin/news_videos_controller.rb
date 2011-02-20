class Admin::NewsVideosController <  Admin::ResourceController
  def create
    @videos = NewsFolder.find(:all, :conditions => "type_id = 3", :order => "name")
    super    
  end
  
  def index
    @news_videos = NewsVideo.paginate :page => params[:page], :per_page => 10
  end
  
  def edit
    @videos = NewsFolder.find(:all, :conditions => "type_id = 3", :order => "name")
    super    
  end  
  
  def new
    @videos = NewsFolder.find(:all, :conditions => "type_id = 3", :order => "name")
    super    
  end
end
