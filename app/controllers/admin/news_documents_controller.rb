class Admin::NewsDocumentsController <  Admin::ResourceController
  def index
    @news_documents = NewsDocument.paginate :page => params[:page], :per_page => 10
  end
end