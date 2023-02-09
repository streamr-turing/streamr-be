class CreateRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendations do |t|
      t.integer :recommendee_id
      t.integer :recommender_id
      t.integer :tmdb_id
      t.string :type

      t.timestamps
    end
  end
end
