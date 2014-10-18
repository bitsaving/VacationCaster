require 'rails_helper'

RSpec.describe "searches/show", :type => :view do
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

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
  end
end
