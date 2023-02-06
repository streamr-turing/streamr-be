class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.integer :recommendee_id
      t.integer :recommender_id
      t.integer :tmbd_id
      t.string :type

      t.timestamps
    end
  end
end
