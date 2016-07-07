Flip &mdash; flip your features
================

[![Build Status](https://travis-ci.org/pda/flip.png)](https://travis-ci.org/pda/flip)

**Flip** provides a declarative, layered way of enabling and disabling application functionality at run-time.

This gem optimizes for:

* developer ease-of-use,
* visibility and control for other stakeholders (like marketing); and
* run-time performance

There are three layers of strategies per feature:

* default
* database, to flip features site-wide for all users
* cookie, to flip features just for you (or someone else)

There is also a configurable system-wide default - !Rails.env.production?` works nicely.

Flip has a dashboard UI that's easy to understand and use.

![Feature Flipper Dashboard](https://cloud.githubusercontent.com/assets/828243/4934741/a5773568-65a4-11e4-98d8-5e9a32720b2e.png)

Install
-------

**Rails 3.0, 3.1 and 3.2+**

    # Gemfile
    gem "flip"
    
    # Generate the model and migration
    > rails g flip:install
    
    # Run the migration
    > rake db:migrate

    # Include the Feature model, e.g. config/initializers/feature.rb:
    require 'feature'

Declaring Features
------------------

```ruby
# This is the model class generated by rails g flip:install
class Feature < ActiveRecord::Base
  include Flip::Declarable

  # The recommended Flip strategy stack.
  strategy Flip::CookieStrategy
  strategy Flip::DatabaseStrategy
  strategy Flip::DefaultStrategy
  default false

  # A basic feature declaration.
  feature :shiny_things

  # Override the system-wide default.
  feature :world_domination, default: true

  # Enabled half the time..? Sure, we can do that.
  feature :flakey,
    default: proc { rand(2).zero? }

  # Provide a description, normally derived from the feature name.
  feature :something,
    default: true,
    description: "Ability to purchase enrollments in courses"

end
```


Checking Features
-----------------

`Flip.on?` or the dynamic predicate methods are used to check feature state:

```ruby
Flip.on? :world_domination   # true
Flip.world_domination?       # true

Flip.on? :shiny_things       # false
Flip.shiny_things?           # false
```

Views and controllers use the `feature?(key)` method:

```erb
<div>
  <% if feature? :world_domination %>
    <%= link_to "Dominate World", world_dominations_path %>
  <% end %>
</div>
```


Feature Flipping Controllers
----------------------------

The `Flip::ControllerFilters` module is mixed into the base `ApplicationController` class.  The following controller will respond with 404 Page Not Found to all but the `index` action unless the `:something` feature is enabled:

```ruby
class SampleController < ApplicationController

  require_feature :something, :except => :index

  def show
  end

  def index
  end

end
```

Dashboard
---------

The dashboard provides visibility and control over the features.

The gem includes some basic styles:

```haml
= content_for :stylesheets_head do
  = stylesheet_link_tag "flip"
```

You probably don't want the dashboard to be public.  Here's one way of implementing access control.

app/controllers/admin/features_controller.rb:

```ruby
class Admin::FeaturesController < Flip::FeaturesController
  before_action :assert_authenticated_as_admin
end
```

app/controllers/admin/strategies_controller.rb:

```ruby
class Admin::StrategiesController < Flip::StrategiesController
  before_action :assert_authenticated_as_admin
end
```

routes.rb:

```ruby
namespace :admin do
  resources :features, only: [ :index ] do
    resources :strategies, only: [ :update, :destroy ]
  end
end

mount Flip::Engine => "/admin/features"
```

Cacheable
---------

You can optimize your feature to ensure that it doesn't make a ton of feature
calls by adding Cacheable to your model.
```ruby
extend Flip::Cacheable
```

This will ensure that your features are eager loaded with one call to the database 
instead of every call to Flip#on? generating a call to the database.  This is
helpful if you have a larger Rails application and more than a few features
defined.

To start or reset the cache, just call #start_feature_cache.


----
Created by Paul Annesley
Copyright © 2011-2013 Learnable Pty Ltd, [MIT Licence](http://www.opensource.org/licenses/mit-license.php).
