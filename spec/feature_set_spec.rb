require "spec_helper"

class NullStrategy < FeatureFlip::AbstractStrategy
  def status(d); nil; end
end

class TrueStrategy < FeatureFlip::AbstractStrategy
  def status(d); true; end
end

describe FeatureFlip::FeatureSet do
  describe ".instance" do
    it "returns a singleton instance" do
      expect(FeatureFlip::FeatureSet.instance).to equal(FeatureFlip::FeatureSet.instance)
    end
    it "can be reset" do
      instance_before_reset = FeatureFlip::FeatureSet.instance
      FeatureFlip::FeatureSet.reset
      expect(FeatureFlip::FeatureSet.instance).to_not equal(instance_before_reset)
    end
    it "can be reset multiple times without error" do
      2.times { FeatureFlip::FeatureSet.reset }
    end
  end

  describe "#on?(:feature)" do
    let(:feature_set) do
      feature_set = FeatureFlip::FeatureSet.new
      feature_set << FeatureFlip::Definition.new(:feature)
      strategies.each { |s| feature_set.add_strategy(s) }
      feature_set
    end
    subject { feature_set.on?(:feature) }

    context "null strategy falling back on default values" do
      let(:strategies) { [NullStrategy] }
      before { feature_set.default = default if defined?(default) }

      context "default" do
        it { should be false }
      end
      context "true" do
        let(:default) { true }
        it { should be true }
      end
      context "proc returning true" do
        let(:default) { proc { true } }
        it { should be true }
      end
      context "proc returning false" do
        let(:default) { proc { false } }
        it { should be false }
      end
    end

    context "null strategy falling back to always-true strategy" do
      let(:strategies) { [NullStrategy, TrueStrategy] }
      it { should be true }
    end

    context "always-true strategy taking priority over null strategy" do
      let(:strategies) { [TrueStrategy, NullStrategy] }
      it do
        expect(feature_set.strategy('null')).to receive(:status).never
        should be true
      end
    end
  end
end
