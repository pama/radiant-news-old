class Admin::NewsDocumentItemsController <  Admin::ResourceController
  def index
    @news_document_items = NewsDocumentItem.paginate :page => params[:page], :per_page => 10
  end
end