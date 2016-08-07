require 'rails_helper'

RSpec.describe "infos/edit", type: :view do
  before(:each) do
    @info = assign(:info, Info.create!())
  end

  it "renders the edit info form" do
    render

    assert_select "form[action=?][method=?]", info_path(@info), "post" do
    end
  end
end
