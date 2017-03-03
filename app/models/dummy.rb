require 'ostruct'
module Dummy
  def self.build_user(id, screen_name, avatar, bio)
    OpenStruct.new(id: id, screen_name: screen_name, avatar: avatar, bio: bio)
  end

  def self.build_article(id, body, published_at)
    OpenStruct.new(id: id, body: body, published_at: published_at)
  end
end
