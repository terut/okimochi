class Api::UsersController < ApplicationController
  def show
    @user = build_dummy
  end

  private
  def build_dummy
    u = Dummy.build_user(1, "kirito", "I always think of Asuna.", nil)
    u.articles = []
    (1..3).each do |i|
      u.articles << Dummy.build_article(i, "It was ... ++#{i}", (Time.zone.now + i.day).iso8601)
    end
    u
  end
end
