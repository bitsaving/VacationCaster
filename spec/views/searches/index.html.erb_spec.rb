require 'rails_helper'

RSpec.describe "searches/index", :type => :view do
  before(:each) do
    assign(:searches, [
      Search.create!(
        :options => "",
        :name => "",
        :slug => "",
        :start_date => "",
        :end_date => "",
        :user_id => 1
      ),
      Search.create!(
        :options => "",
        :name => "",
        :slug => "",
        :start_date => "",
        :end_date => "",
        :user_id => 1
      )
    ])
  end

  it "renders a list of searches" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
