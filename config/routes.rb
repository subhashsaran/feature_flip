FeatureFlip::Engine.routes.draw do

  scope module: "feature_flip" do

    resources :features, path: "", only: [ :index ] do

      resources :strategies,
        only: [ :update, :destroy ]

    end

  end

end
