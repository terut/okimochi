# Private API endpoint
Use json schema

* [Articles](#articles)
 * [POST /articles.json](#post-articles.json)
 * [PATCH /articles/:id.json](#patch-articlesid.json)
* [Boards](#boards)
 * [GET /boards.json](#get-boards.json)
* [Users](#users)
 * [GET /users/:id.json](#get-usersid.json)

## Articles


### Properties
* id
 * id
 * Example: `1`
 * Type: integer
* body
 * Example: `"Today, I defeated my opponent."`
 * Type: string
* published_on
 * Example: `"2017-03-01"`
 * Type: string
* edited_at
 * Example: `"2017-03-01T18:00:00Z"`
 * Type: string
 * Format: date-time
* user
 * Return user

### POST /articles.json
Create article

```
POST /articles.json HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "body": "Today, I defeated my opponent.",
  "published_on": "2017-03-01",
  "edited_at": "2017-03-01T18:00:00Z",
  "user": {
    "id": 1,
    "username": "kirito",
    "name": "Kirito",
    "avatar": "https://www.gravatar.com/avatar/2fca43655bea294ead4418b60ffbc7a0.jpg?s=200",
    "bio": "I'm Beater."
  }
}
```

### PATCH /articles/:id.json
Update article

```
PATCH /articles/:id.json HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "body": "Today, I defeated my opponent.",
  "published_on": "2017-03-01",
  "edited_at": "2017-03-01T18:00:00Z",
  "user": {
    "id": 1,
    "username": "kirito",
    "name": "Kirito",
    "avatar": "https://www.gravatar.com/avatar/2fca43655bea294ead4418b60ffbc7a0.jpg?s=200",
    "bio": "I'm Beater."
  }
}
```

## Boards


### Properties
* id
 * id
 * Example: `1`
 * Type: integer
* username
 * Example: `"kirito"`
 * Type: string
 * Pattern: `/^\w{5}$/`
* name
 * Example: `"Kirito"`
 * Type: string
* avatar
 * Example: `"https://www.gravatar.com/avatar/2fca43655bea294ead4418b60ffbc7a0.jpg?s=200"`
 * Type: string
* bio
 * Example: `"I'm Beater."`
 * Type: null, string
* current_article

### GET /boards.json
List users with current article

```
GET /boards.json HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "username": "kirito",
    "name": "Kirito",
    "avatar": "https://www.gravatar.com/avatar/2fca43655bea294ead4418b60ffbc7a0.jpg?s=200",
    "bio": "I'm Beater.",
    "current_article": {
      "id": 1,
      "body": "Today, I defeated my opponent.",
      "published_on": "2017-03-01",
      "edited_at": "2017-03-01T18:00:00Z"
    }
  }
]
```

## Users


### Properties
* id
 * id
 * Example: `1`
 * Type: integer
* username
 * Example: `"kirito"`
 * Type: string
 * Pattern: `/^\w{5}$/`
* name
 * Example: `"Kirito"`
 * Type: string
* avatar
 * Example: `"https://www.gravatar.com/avatar/2fca43655bea294ead4418b60ffbc7a0.jpg?s=200"`
 * Type: string
* bio
 * Example: `"I'm Beater."`
 * Type: null, string
* articles
 * Type: array

### GET /users/:id.json
Get a single user with the user's articles a month

* date
 * Get user with articles on March, 2017
 * Example: `"2017-03-15"`

```
GET /users/:id.json?date=2017-03-15 HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "username": "kirito",
  "name": "Kirito",
  "avatar": "https://www.gravatar.com/avatar/2fca43655bea294ead4418b60ffbc7a0.jpg?s=200",
  "bio": "I'm Beater.",
  "articles": [
    {
      "id": 1,
      "body": "Today, I defeated my opponent.",
      "published_on": "2017-03-01",
      "edited_at": "2017-03-01T18:00:00Z"
    }
  ]
}
```

