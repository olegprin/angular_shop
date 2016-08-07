require 'rails_helper'

RSpec.describe "infos/index", type: :view do
  before(:each) do
    assign(:infos, [
      Info.create!(),
      Info.create!()
    ])
  end

  it "renders a list of infos" do
    render
  end
end
