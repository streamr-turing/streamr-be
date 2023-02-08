class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :watchlists, :type, :media_type
  end
end
