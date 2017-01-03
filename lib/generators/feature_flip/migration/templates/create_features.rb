# Created by the feature flip gem, see https://github.com/subhashsaran/feature_flip
class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :key, null: false
      t.boolean :enabled, null: false, default: false

      t.timestamps null: false
    end
  end
end
