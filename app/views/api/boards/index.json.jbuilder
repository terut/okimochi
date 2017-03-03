json.array! @users do |u|
  json.(u, :id, :screen_name, :avatar)
  json.current_article u.current_article, :id, :body, :published_at
end
