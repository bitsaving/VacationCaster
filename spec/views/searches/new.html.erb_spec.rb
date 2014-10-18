require 'rails_helper'

RSpec.describe "searches/new", :type => :view do
  before(:each) do
    assign(:search, Search.new(
      :options => "",
      :name => "",
      :slug => "",
      :start_date => "",
      :end_date => "",
      :user_id => 1
    ))
  end

  it "renders new search form" do
    render

    assert_select "form[action=?][method=?]", searches_path, "post" do

      assert_select "input#search_options[name=?]", "search[options]"

      assert_select "input#search_name[name=?]", "search[name]"

      assert_select "input#search_slug[name=?]", "search[slug]"

      assert_select "input#search_start_date[name=?]", "search[start_date]"

      assert_select "input#search_end_date[name=?]", "search[end_date]"

      assert_select "input#search_user_id[name=?]", "search[user_id]"
    end
  end
end
