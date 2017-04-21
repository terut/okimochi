# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Dummy user

if Rails.env.development?
  User.create(
    [
      {
        username: 'kirito',
        email: 'kirito@example.com',
        name: 'kirito',
        magic_link_token: 'a8ef484f73de5ad0a7cee41974ac12a89ed566dc',
        magic_link_expires_at: '2099-03-01T23:59:59Z',
        magic_link_sent_at: '2017-03-01T13:00:00Z',
        time_zone: "UTC"
      },
      {
        username: 'asuna',
        email: 'asuna@example.com',
        name: 'asuna',
        magic_link_token: '2e4c00caf8ed9bca5013ec614d0edf90fd4c609a',
        magic_link_expires_at: '2099-03-01T23:59:59Z',
        magic_link_sent_at: '2017-03-01T13:00:00Z',
        time_zone: "UTC"
      }
    ]
  ) unless User.exists?(username: 'kirito')

  unless Article.exists?
    u = User.find(1)
    u.articles.create([
      {
        body: "I'm beater.",
        published_on: "2017-03-02",
        edited_at: "2017-03-02T18:00:00Z"
      },
      {
        body: "Beater, huh? Sounds good to me.",
        published_on: "2017-03-03",
        edited_at: "2017-03-03T18:00:00Z"
      },

    ])
    u = User.find(2)
    u.articles.create([
      {
        body: "Help...Kirito..",
        published_on: "2017-03-04",
        edited_at: "2017-03-04T18:00:00Z"
      }
    ])
  end
end
