require "spec_helper"

describe FeatureFlip::Cacheable do

  subject(:model_class) do
    class Sample
      attr_accessor :key
    end

    Class.new do
      extend FeatureFlip::Declarable
      extend FeatureFlip::Cacheable

      strategy FeatureFlip::DeclarationStrategy
      default false

      feature :one
      feature :two, description: "Second one."
      feature :three, default: true

      def self.all
        list = []
        i = 65
        3.times do
          list << Sample.new
          list.last.key = i.chr()
          i += 1
        end
        list
      end
    end
  end

  describe "with feature cache" do
    context "initial context" do
      it { should respond_to(:use_feature_cache) }
      it { should respond_to(:start_feature_cache) }
      it { should respond_to(:feature_cache) }
      its(:use_feature_cache) { should be_nil }
    end

    context "after a cache clear" do
      before { model_class.start_feature_cache }
      its(:use_feature_cache) { should be true }
      its("feature_cache.size") { should eq 3 }
    end
  end

end
