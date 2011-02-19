require File.dirname(__FILE__) + '/../spec_helper'

describe NewsFolder do
  before(:each) do
    @news_folder = NewsFolder.new
  end

  it "should be valid" do
    @news_folder.should be_valid
  end
end
