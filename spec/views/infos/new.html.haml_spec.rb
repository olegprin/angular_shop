require 'rails_helper'

RSpec.describe "infos/new", type: :view do
  before(:each) do
    assign(:info, Info.new())
  end

  it "renders new info form" do
    render

    assert_select "form[action=?][method=?]", infos_path, "post" do
    end
  end
end
