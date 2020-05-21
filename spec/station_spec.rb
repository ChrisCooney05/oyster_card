require 'station'

describe Station do
  it "should respond to having two arguments called" do
    expect(Station).to respond_to(:new).with(2).arguments
  end
end
