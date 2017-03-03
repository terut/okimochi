class Api::BoardsController < ApplicationController
  def index
    @users = build_dummies
  end

  private
  def build_dummies
    ["kirito", "asuna"].each.with_index.with_object([]) do |(v, i), arr|
      u = Dummy.build_user(i + 1, v, nil, nil)
      u.current_article = Dummy.build_article(i + 1, "It was ...", (Time.zone.now - (i + 1).day).iso8601)
      arr << u
    end
  end
end
