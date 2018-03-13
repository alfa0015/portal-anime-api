json.array!(@anime.tags) do |tag|
  json.name tag["name"]
end
