class CreateWatchlists < ActiveRecord::Migration[5.2]
  def change
    create_table :watchlists do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :tmdb_id
      t.string :type

      t.timestamps
    end
  end
end
