class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :memberships, :beer_cub_id, :beer_club_id
  end
end
