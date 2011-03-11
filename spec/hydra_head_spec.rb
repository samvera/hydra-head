require 'spec_helper'

describe Hydra::Head do
  it "should be valid" do
    Hydra::Head.should be_a(Module)
  end
end