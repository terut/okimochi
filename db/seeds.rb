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
        magic_link_token: 'a8ef484f73de5ad0a7cee41974ac12a89ed566dc',
        magic_link_expires_at: '2099-03-01T23:59:59Z',
        magic_link_sent_at: '2017-03-01T13:00:00Z'
      },
      {
        username: 'asuna',
        email: 'asuna@example.com',
        magic_link_token: '2e4c00caf8ed9bca5013ec614d0edf90fd4c609a',
        magic_link_expires_at: '2099-03-01T23:59:59Z',
        magic_link_sent_at: '2017-03-01T13:00:00Z'
      }
    ]
  )
end
