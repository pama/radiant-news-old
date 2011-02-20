class Admin::NewsDocumentsController <  Admin::ResourceController
  def create
    @documents = NewsFolder.find(:all, :conditions => "type_id = 1", :order => "name")
    super    
  end
  
  def index
    @news_documents = NewsDocument.paginate :page => params[:page], :per_page => 10
  end
  
  def edit
    @documents = NewsFolder.find(:all, :conditions => "type_id = 1", :order => "name")
    super    
  end  
  
  def new
    @documents = NewsFolder.find(:all, :conditions => "type_id = 1", :order => "name")
    super    
  end
end