require File.dirname(__FILE__) + '/../spec_helper'

describe NewsGalleryImage do
  before(:each) do
    @news_gallery_image = NewsGalleryImage.new
  end

  it "should be valid" do
    @news_gallery_image.should be_valid
  end
end
