require "spec_helper"
describe Zombie do
  it 'is invilid without a name' do
    zombie =Zombie.new
    zombie.should_not be_valid
  end
end
