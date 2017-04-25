# Private API endpoint
Use json schema

* [Articles](#articles)
 * [POST /articles](#post-articles)
 * [PATCH /articles/:id](#patch-articlesid)
 * [GET /article](#get-article)
* [AuthenticatedUser](#authenticateduser)
 * [GET /user](#get-user)
* [Boards](#boards)
 * [GET /boards](#get-boards)
* [Users](#users)
 * [GET /users/:id](#get-usersid)

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

### POST /articles
Create article

```
POST /articles HTTP/1.1
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

### PATCH /articles/:id
Update article

```
PATCH /articles/:id HTTP/1.1
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

### GET /article
Today's article. Return `204 No Content` if authenticated user haven't write today's article yet.

```
GET /article HTTP/1.1
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

## AuthenticatedUser


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
* time_zone
 * time zone
 * Example: `"Asia/Tokyo"`
 * Type: string

### GET /user
Get authenticated user

```
GET /user HTTP/1.1
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
  "time_zone": "Asia/Tokyo"
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

### GET /boards
List users with current article

```
GET /boards HTTP/1.1
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

### GET /users/:id
Get a single user with the user's articles a month

* month
 * Get user with articles on March, 2017
 * Example: `"2017-03"`

```
GET /users/:id?month=2017-03 HTTP/1.1
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

