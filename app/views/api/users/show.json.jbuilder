@user.tap do |u|
  json.(u, :id, :screen_name, :avatar, :bio)
  json.articles u.articles, :id, :body, :published_at
end
