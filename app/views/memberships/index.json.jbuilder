json.array!(@memberships) do |membership|
  json.extract! membership, :id, :beer_cub_id, :user_id
  json.url membership_url(membership, format: :json)
end
