require "spec_helper"
require "lib/zombie"
describe Zombie do
  it "is named Ash" do
    zombie = Zombie.new
    zombie.name.should == 'Ash'
  end
  it "has no brains" do
    zombie =Zombie.new
    zombie.brains.should < 1
  end
end
describe Zombie do
  it 'is hungry' do
    zombie =Zombie.new
    zombie.should be_hungry== true
  end
end
