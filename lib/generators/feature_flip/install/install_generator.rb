class FeatureFlip::InstallGenerator < Rails::Generators::Base

  def invoke_generators
    %w{ model migration routes }.each do |name|
      generate "feature_flip:#{name}"
    end
  end

end
