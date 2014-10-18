require 'rails_helper'

RSpec.describe "searches/edit", :type => :view do
  before(:each) do
    @search = assign(:search, Search.create!(
      :options => "",
      :name => "",
      :slug => "",
      :start_date => "",
      :end_date => "",
      :user_id => 1
    ))
  end

  it "renders the edit search form" do
    render

    assert_select "form[action=?][method=?]", search_path(@search), "post" do

      assert_select "input#search_options[name=?]", "search[options]"

      assert_select "input#search_name[name=?]", "search[name]"

      assert_select "input#search_slug[name=?]", "search[slug]"

      assert_select "input#search_start_date[name=?]", "search[start_date]"

      assert_select "input#search_end_date[name=?]", "search[end_date]"

      assert_select "input#search_user_id[name=?]", "search[user_id]"
    end
  end
end
