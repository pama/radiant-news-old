class Admin::NewsFoldersController <  Admin::ResourceController
  @@options = [['Documentos', 1],['Galeria', 2],['Videos',3]]
  
  def create
    super
    @news_folder.type_name = @@options[@news_folder.type_id-1][0]
    @news_folder.save
  end
  
  def edit
    @options = @@options
    super
  end
  
  def index
    @news_folders = NewsFolder.paginate :page => params[:page], :per_page => 10
    @options = @@options
  end
  
  def new
    @options = @@options
    super
  end
  
  def update
    super
    @options = @@options
    @news_folder.type_name = @options[@news_folder.type_id - 1][0]
    @news_folder.save
  end
end
