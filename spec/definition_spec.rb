require "spec_helper"

describe FeatureFlip::Definition do

  subject { FeatureFlip::Definition.new :the_key, description: "The description" }

  [:key, :name, :to_s].each do |method|
    its(method) { should == :the_key }
  end

  its(:description) { should == "The description" }
  its(:options) { should == { description: "The description" } }

  context "without description specified" do
    subject { FeatureFlip::Definition.new :the_key }
    its(:description) { should == "The key." }
  end

end
