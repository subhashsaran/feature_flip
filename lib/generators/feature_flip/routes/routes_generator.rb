class FeatureFlip::RoutesGenerator < Rails::Generators::Base

  def add_route
    route %{mount FeatureFlip::Engine => "/feature_flip"}
  end

end
