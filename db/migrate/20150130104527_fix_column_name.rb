class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :Memberships, :beer_cub_id, :beer_club_id
  end
end
