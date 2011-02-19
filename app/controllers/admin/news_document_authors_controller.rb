class Admin::NewsDocumentAuthorsController <  Admin::ResourceController
  def index
    @news_document_authors = NewsDocumentAuthor.paginate :page => params[:page], :per_page => 10
  end
end
