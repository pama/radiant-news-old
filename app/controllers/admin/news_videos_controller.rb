class Admin::NewsVideosController <  Admin::ResourceController
  def index
    @news_videos = NewsVideo.paginate :page => params[:page], :per_page => 10
  end

  def toggle
  end
end
