require File.dirname(__FILE__) + '/../spec_helper'

describe NewsDocumentItems do
  before(:each) do
    @news_document_items = NewsDocumentItems.new
  end

  it "should be valid" do
    @news_document_items.should be_valid
  end
end
