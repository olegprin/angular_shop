require 'rails_helper'

RSpec.describe "angulars/show", type: :view do
  before(:each) do
    @angular = assign(:angular, Angular.create!(
      :title => "Title",
      :body => "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Body/)
  end
end
