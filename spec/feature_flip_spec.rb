require "spec_helper"

describe FeatureFlip do

  before(:all) do
    Class.new do
      extend FeatureFlip::Declarable
      strategy FeatureFlip::DeclarationStrategy
      default false
      feature :one, default: true
      feature :two, default: false
    end
  end

  after(:all) do
    FeatureFlip.reset
  end

  describe ".on?" do
    subject { FeatureFlip.on?(key) }
    it "returns true for enabled features" do
      expect(FeatureFlip.on?(:one)).to be true
    end
    it "returns false for disabled features" do
      expect(FeatureFlip.on?(:two)).to be false
    end
  end

  describe "dynamic predicate methods" do
    its(:one?) { should be true }
    its(:two?) { should be false }
  end

end
