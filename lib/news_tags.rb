module NewsTags
  include Radiant::Taggable

  desc %{
    Gets scrolltext with active news.

    *Usage:*
    <r:news:marquee [behavior="scroll"] [direction="left"] [loop="true"] [scrollamount="1"] [scrolldelay="2"] />
  }
  tag 'newsMarquee' do |tag|
    html = ''
    currentnews.each do |news|
      html += '<b>' + news.headline+'</b>: ' + news.leadtext + " "
    end
    
    content_tag(:marquee, html, 
      :behavior => tag.attr['behavior='],
      :direction => tag.attr['direction'],
      :loop => tag.attr['loop'],
      :scrollamount  => tag.attr['scrollamount'],
      :scrolldelay  => tag.attr['scrolldelay'])
  end

  tag 'news' do |tag|
    tag.expand
  end

  desc %{
    Allow to iterate over news which are active today.
    
    *Usage:*
    <pre><code>
      <r:news:current [category="category_name"] [tag="tag_name"] [offset="offset_number"] [limit="limit_number"]>
      ... </r:news:current>
    </code></pre>
    
    or get specific by id
    <pre><code>
      <r:news:current id="1">
      ... </r:news:current>
    </code></pre>
  }
  tag 'news:current' do |tag|
    result = []
    options = {}

    #process options
    options.merge!({:limit => tag.attr["limit"].to_i}) if tag.attr["limit"]
    options.merge!({:offset => tag.attr["offset"].to_i}) if tag.attr["offset"]
    
    #process categories
    category_arr = tag.attr['category'].split(",").map {|x| x.strip} if tag.attr['category']
    options.merge!({:categories => category_arr})if category_arr
    
    #process tags
    tag_arr = tag.attr['tag'].split(",").map {|x| x.strip} if tag.attr['tag']
    options.merge!({:tags => tag_arr})if tag_arr
    
    #process id    
    options.merge!({:id => tag.attr['id']})if tag.attr
        
    news = currentnews(options)
    news.each do |x|
      tag.locals.news = x
      result << tag.expand
    end
    result
  end

  desc %{
    Return the specific news entry. this does the same thing using <r:news:current id="">
    
    *Usage:*
    <pre><code>
      <r:news:entry> ... </r:news:entry>
    </code></pre>
  }
  tag 'news:entry' do |tag|
    result = []
    entry_id = @request.parameters[:entry_id]
    news  = currentnews({:id => entry_id})     
    
    news.each do |x|
      tag.locals.news = x
      result << tag.expand
    end
    result
  end

  desc %{
    Returns headline of current news
  }
  tag 'news:headline' do |tag|
    tag.locals.news.headline
  end

  desc %{
    Returns ante headline of current news
  }
  tag 'news:ante_headline' do |tag|
    tag.locals.news.ante_headline
  end

  desc %{
    Returns leadtext of current news
  }
  tag 'news:leadtext' do |tag|
    tag.locals.news.leadtext
  end

  desc %{
    Returns text of current news
  }
  tag 'news:text' do |tag|
    tag.locals.news.text
  end

  desc %{
    If text image url exists
  }
  tag 'news:if_text_image' do |tag|
    if tag.locals.news.photo_text.file?
      tag.expand
    end
  end

  desc %{
    Returns text image url of current news
  }
  tag 'news:text_image' do |tag|
    tag.locals.news.photo_text.url(:medium)
  end

  desc %{
    Returns text caption for text image
  }
  tag 'news:text_caption' do |tag|
    tag.locals.news.photo_text_caption
  end

  desc %{
    If lead image url exists
  }
  tag 'news:if_lead_image' do |tag|
    if tag.locals.news.photo_lead.file?
      tag.expand
    end
  end

  desc %{
    Returns text image url of current news
  }
  tag 'news:lead_highlight_image_url' do |tag|
    tag.locals.news.photo_lead.url(:highlight)
  end
  
  desc %{
    Returns text image url of current news
  }
  tag 'news:lead_latest_image_url' do |tag|
    tag.locals.news.photo_lead.url(:latest)
  end
  
  desc %{
    Returns link to current news
    
    *Usage:*
    <pre><code>
      <r:news:link [class="class_name"]>
      
    </code></pre>
  }
  tag 'news:link' do |tag|
    #process class
    class_arg = tag.attr["class"] if tag.attr["class"]  
    
    result = ""
    url = NewsEntryPage.first.url if NewsEntryPage.first
    if url
      id = tag.locals.news.id
      result = "<a href=\"#{url}?entry_id=#{id}\""
      result += "class=\"#{class_arg}\"" if class_arg
      result += ">"
      result << tag.expand
      result << %{</a>}
    end
    result
  end
  
  desc %{
    Returns the full url for the actual news entry
    
    *Usage:*
    <pre><code>
      <r:news:url />
      
    </code></pre>
  }
  tag 'news:url' do |tag|
    
    result = ""
    url = NewsEntryPage.first.url if NewsEntryPage.first
    if url
      id = tag.locals.news.id
      result = "#{url}?entry_id=#{id}\""      
    end
    result
  end

  desc %{
    Returns the start date
  }
  tag 'news:date' do |tag|
    tag.locals.news.start
  end

  #
  # video
  #
  desc %{
    get the video for the main page, if available
  }
  tag 'news:video_main_current' do |tag|
    result = []
    video = NewsVideo.find(:first, :conditions => ["show_in_main_page = ?", true])
    if video != nil    
      tag.locals.video_item = video     
      result << tag.expand 
    end   
    result
  end
  
  desc %{
    If video exists
  }
  tag 'news:if_video' do |tag|
    if tag.locals.news.news_video_id != nil
      tag.expand
    end
  end
  
  desc %{
    Iterates all videos from a video gallery
  }
  tag 'news:video_current' do |tag|
    result = []
    news_videos = NewsVideo.find(:all, :conditions => ["news_folder_id = ?", tag.locals.news.news_video_id ])                                                                        
    
    news_videos.each do |x|
      tag.locals.video_item = x
      result << tag.expand
    end
    
    tag.locals.z = "olá"
    result
  end
  
  # improve this code!
  desc %{
    Get video pagination
  }
  tag 'news:video_item_pagination' do |tag|
    result = []
    entry_id = @request.parameters[:entry_id]
    news  =  NewsEntry.find(entry_id)
    z = NewsVideo.find(:all, :conditions => ["news_folder_id = ?", news.news_video_id ])    
    count = z.count
    
    to_return = ''
    x = 0    
    count.times do |x|
      to_return += ('<li><a id="t' + String(x) + '" href="#video-' + String(x) + '">' + String(x) + '</a></li>')       
    end
    
    to_return        
  end
  
  desc %{
    Get video url
  }
  tag 'news:video_item_url' do |tag|
    tag.locals.video_item.video_url
  end  
  
  desc %{
    Get video title
  }
  tag 'news:video_item_title' do |tag|
    tag.locals.video_item_title
  end

  desc %{
    Get video ante title
  }
  tag 'news:video_item_ante_title' do |tag|
    tag.locals.video_item.ante_title
  end
  
  desc %{
    Get video description
  }
  tag 'news:video_item_description' do |tag|
    tag.locals.video_item.description
  end

  #
  # Documents
  #

  desc %{
    If document exists
  }
  tag 'news:if_document' do |tag|
    if tag.locals.news.news_document_id != nil
      tag.expand
    end
  end
  
  desc %{
    Iterates all images from a gallery
  }
  tag 'news:document_current' do |tag|
    result = []
    images = NewsDocument.find(:all, :conditions => ["news_folder_id = ?", tag.locals.news.news_document_id  ])
    images.each do |x|
      tag.locals.document = x
      result << tag.expand
    end
    result
  end
  
  desc %{
    Get document item title
  }
  tag 'news:document_item_title' do |tag|
    tag.locals.document.title
  end
  
  desc %{
    Get document item date
  }
  tag 'news:document_item_date' do |tag|
    tag.locals.document.date
  end
  
  desc %{
    Get document item description
  }
  tag 'news:document_item_description' do |tag|
    tag.locals.document.description
  end
  
  desc %{
    Get document item authors
  }
  tag 'news:document_item_authors' do |tag|
    tag.locals.document.authors
  end
  
  desc %{
    Get document item file
  }
  tag 'news:document_item_url' do |tag|
    tag.locals.document.document.url
  end
  
  #
  # Gallery
  #

  desc %{
    If gallery exists
  }
  tag 'news:if_gallery' do |tag|
    if tag.locals.news.news_gallery_image_id != nil
      tag.expand
    end
  end
  
  desc %{
    Iterates all images from a gallery
  }
  tag 'news:gallery_current' do |tag|
    result = []
    images = NewsGalleryImage.find(:all, :conditions => ["news_folder_id = ?", tag.locals.news.news_gallery_image_id  ])
    images.each do |x|
      tag.locals.gallery_item = x
      result << tag.expand
    end
    result
  end
  
  desc %{
    Get gallery item title
  }
  tag 'news:gallery_item_title' do |tag|
    tag.locals.gallery_item.title
  end
  
  desc %{
    Get gallery item description
  }
  tag 'news:gallery_item_description' do |tag|
    tag.locals.gallery_item.description
  end

  desc %{
    Get gallery item small title
  }
  tag 'news:gallery_item_small_title' do |tag|
    tag.locals.gallery_item.small_title
  end
  
  desc %{
    Get gallery item small description
  }
  tag 'news:gallery_item_small_description' do |tag|
    tag.locals.gallery_item.small_description
  end
  
  desc %{
    Get gallery item url
  }
  tag 'news:gallery_item_photo_url' do |tag|
    tag.locals.gallery_item.photo.url(:medium)
  end
  
  desc %{
    Get gallery item small url
  }
  tag 'news:gallery_item_small_photo_url' do |tag|
    tag.locals.gallery_item.photo.url(:small)
  end

  ##################################################################################################
  def currentnews(parameter)
    curr_date = Time.now
    str_conditions = 'start <=  ? and (stop is null or stop >= ?)'
    arr_parameter = [curr_date, curr_date]
    arr_table_join = []
    
    if parameter[:id]
      str_conditions += ' AND news_entries.id = ?'
      arr_parameter += [parameter[:id]]
    else          
      if parameter[:categories] #Array of String category ex ['Category 1','Category 2'] 
        str_conditions += ' AND news_categories.name in (?)'
        arr_parameter += [parameter[:categories]]
        arr_table_join += ['news_categories']
      end
      
      if parameter[:tags] #Array of String tag ex ['Tag 1', 'Tag 2'] 
        str_conditions += ' AND news_tags.name in (?)'
        arr_parameter += [parameter[:tags]]
        arr_table_join += ['news_tags']
      end
    end

    #arr_table_join += ['news_video']
    
    find_parameters = {:conditions => [str_conditions] + arr_parameter, :order => 'start DESC, news_entries.id DESC'}    
    find_parameters.merge!({:include => arr_table_join}) if arr_table_join
    find_parameters.merge!({:limit => parameter[:limit]}) if parameter[:limit]
    find_parameters.merge!({:offset => parameter[:offset]}) if parameter[:offset]

    NewsEntry.find(:all, find_parameters)
  end
end
