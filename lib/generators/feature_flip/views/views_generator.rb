class FeatureFlip::ViewsGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_view_index_file
    copy_file "index.html.erb", "app/views/feature_flip/features/index.html.erb"
  end

end
