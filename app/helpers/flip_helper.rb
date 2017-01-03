# Access to feature-flipping configuration.
module FeatureFlipHelper

  # Whether the given feature is switched on
  def feature?(key)
    FeatureFlip.on? key
  end

end
