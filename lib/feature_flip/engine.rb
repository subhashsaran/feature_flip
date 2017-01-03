module FeatureFlip
  class Engine < ::Rails::Engine

    initializer "feature_flip.blarg" do
      ActionController::Base.send(:include, FeatureFlip::CookieStrategy::Loader)
    end

  end
end
