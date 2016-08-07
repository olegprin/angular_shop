require 'rails_helper'

RSpec.describe "infos/show", type: :view do
  before(:each) do
    @info = assign(:info, Info.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
