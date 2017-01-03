class Feature < ActiveRecord::Base
  extend FeatureFlip::Declarable

  strategy FeatureFlip::CookieStrategy
  strategy FeatureFlip::DatabaseStrategy
  strategy FeatureFlip::DeclarationStrategy
  default false

  # Declare your features here, e.g:
  #
  # feature :world_domination,
  #   default: true,
  #   description: "Take over the world."

end
