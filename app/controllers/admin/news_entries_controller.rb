class Admin::NewsEntriesController <  Admin::ResourceController
  def tags_to_arr(tag_str)    
    tags = params[:news_entry][:news_tags].split(",")
    tag_str.split(",").map do |tag|
      tag.strip!      
      tag_object = NewsTag.find_by_name(tag) || NewsTag.new(:name => tag)       
    end
  end
  
  def create
    @news_categories = NewsCategory.find(:all, :order => "name ASC")
    @videos = NewsFolder.find(:all, :order => "name ASC", :conditions => "type_id=3")
    @galleries = NewsFolder.find(:all, :order => "name ASC", :conditions => "type_id=2")
    @documents = NewsFolder.find(:all, :order => "name ASC", :conditions => "type_id=1")     
    params[:news_entry][:news_tags] = tags_to_arr(params[:news_entry][:news_tags])
    super
  end
  
  def update
    params[:news_entry][:news_category_ids] ||= []         
    params[:news_entry][:news_tags] = tags_to_arr(params[:news_entry][:news_tags])
    super
  end
  
  def new
    @news_categories = NewsCategory.find(:all, :order => "name ASC")
    @videos = NewsFolder.find(:all, :order => "name ASC", :conditions => "type_id=3")
    @galleries = NewsFolder.find(:all, :order => "name ASC", :conditions => "type_id=2")
    @documents = NewsFolder.find(:all, :order => "name ASC", :conditions => "type_id=1")
  end
  
  def edit
    @news_categories = NewsCategory.find(:all, :order => "name ASC")
    @videos = NewsFolder.find(:all, :order => "name ASC", :conditions => "type_id=3")
    @galleries = NewsFolder.find(:all, :order => "name ASC", :conditions => "type_id=2")
    @documents = NewsFolder.find(:all, :order => "name ASC", :conditions => "type_id=1")
  end
  
  def index
    
    # TODO: this filter code should be improved    
    conditions = ""
    conditions_arr = [] 
    
    if params[:headline_text] != nil and params[:headline_text] != ""             
      conditions += "headline LIKE ?"
      conditions_arr << "%" + params[:headline_text] + "%"
    end
    
    if params[:category_id] != nil and Integer(params[:category_id]) != 0
      if conditions != ""
        conditions += " AND "
      end
      
      conditions += "news_categories.id = ?"
      conditions_arr << params[:category_id]

      @news_entries = NewsEntry.paginate :page => params[:page], :per_page => 10, :include => 'news_categories', :conditions => [conditions] + conditions_arr, :order => "start DESC"
    else      
      @news_entries = NewsEntry.paginate :page => params[:page], :per_page => 10, :conditions => [conditions] + conditions_arr, :order => "start DESC"
    end
  
    @news_categories = NewsCategory.find(:all, :order => "name ASC")
  end
end
