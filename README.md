<div align="center">
  <h1>Streamr API</h1>

</div>

## Table of Contents
- [Project Overview](#project-overview)
- [Learning Goals](#learning-goals)
- [Setup](#setup)
- [Endpoints](#endpoints)
- [Schema](#schema)
- [Contributors](#contributors)
- [Gems](#gems)


## Project Overview
Streamr is an application meant to help users exchange and manage TV show/movie recommendations by creating a space where users can make direct recommendations to other users, browse through TV shows/movies, see the details of a show/movie such as streaming availability, and save those shows/movies to a watchlist for later.

This repo is the back end service of a project built by students at [Turing School of Software and Design](https://turing.edu/). You can find the Front End repo [HERE](https://github.com/streamr-turing/streamr-fe), and the app is deployed [HERE](https://main--frabjous-halva-33ef87.netlify.app/)



## Learning Goals
[Project Spec](https://mod4.turing.edu/projects/capstone/)

This project's goal was to synthesize the knowledge accumulated over the course of the Turing web development program in order to produce a complete web application from a student-led project idea, focusing on Service-Oriented Architecture with separate front end and back end teams. Communication was crucial as each team was composed of students who were trained solely for their respective side of the stack. As part of the project requirements, a stretch tech had to be learned and incorporated into both ends of the application. GraphQL was the chosen stretch tech for this application. Agile methodologies were also implemented to manage the project during the two-week time period given to complete the Minimum Viable Product.
The back-end handles the project's API consumption and acts as the interface to the project's database.

## Setup
This application uses Ruby 2.7.2 and Rails 5.2.8.1

This application uses [The Movie Database (TMDB) API](https://developers.themoviedb.org/3/getting-started/introduction). You will need to register for your own api key. 

1. Clone the repository
2. Navigate into the root directory
3. Install gem packages: `bundle install`
4. Setup the database: `rails db:{drop,create,migrate}`
5. Configure API key by running `bundle exec figaro install` and then adding the key to `application.yml` file:
```ruby
tmdb_api_key: your_key_here
```
6. Run `rails s` to start the server
7. Visit the endpoint url `http://localhost:3000/graphql` to consume the API locally.
8. You may run the RSpec test suite locally with `bundle exec rspec`

## Endpoints
Back End Server: https://streamr_be.herokuapp.com/

This application uses GraphQL and therefore all requests should be sent as `POST https://streamr-be.herokuapp.com/graphql` with the appropriate query in the request body. 

After setup, non-static documentation is available using GraphiQL, GraphQL's IDE, by visiting `localhost:3000/graphiql`. Static documentation is provided below to give an initial sense of available data.

- ### Fetch Users
<details close>
<summary>Fetch All Users in the Database</summary>
<br>
Request Body: <br>
  
```
  query {
    users {
        id
        username
        avatarUrl
    }
  }
```
  
JSON Response Example: 
```json 
  {
  "data": {
    "users": [
      {
        "id": "1",
        "username": "snoop_dogg",
        "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940414.png"
      },
      {
        "id": "2",
        "username": "martha_stewart",
        "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940448.png"
      },
      {...},
      {...}
    ]
  }
```
</details>

<details close>
<summary>Fetch One User From the Database by ID</summary>
<br>
Request Body: <br>
  
```
query {
	fetchUser (
  	id: 5
  )
  {
    id
    username
    avatarUrl
    watchlistItems {
      show {
        tmdbId
        title
        releaseYear
        posterUrl
        mediaType
      }
    }
    recommendations {
      id
      recommendeeId
      recommender {
        id
        username
        avatarUrl
      }
      show {
        tmdbId
        title
        releaseYear
        rating
        genres
        posterUrl
        mediaType
      }
      createdAt
    }
  }
}
```
  
JSON Response Example: 
```json 
 {
  "data": {
    "fetchUser": {
      "id": "5",
      "username": "the_burger_king",
      "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940429.png",
      "watchlistItems": [
        {
          "show": {
            "tmdbId": 76331,
            "title": "Succession",
            "releaseYear": "2018",
            "posterUrl": "https://image.tmdb.org/t/p/w500/e2X32jUfJ2kb4QtNg3WCTnLyGxD.jpg",
            "mediaType": "tv"
          }
        },
        {..},
        {..}
      ],
      "recommendations": [
        {
          "id": "5",
          "recommendeeId": 5,
          "recommender": {
            "id": "4",
            "username": "sean_not_shaun",
            "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940421.png"
          },
          "show": {
            "tmdbId": 4608,
            "title": "30 Rock",
            "releaseYear": "2006",
            "rating": 7.45,
            "genres": [
              "Comedy"
            ],
            "posterUrl": "https://image.tmdb.org/t/p/w500/k3RbNzPEPW0cmkfkn1xVCTk3Qde.jpg",
            "mediaType": "tv"
          },
          "createdAt": "2023-02-12T19:29:41Z"
        },
        {..},
        {..}
      ]
    }
  }
}
```
</details>

- ### Shows
<details close>

<summary>Search for Shows with Keyword</summary>
<br>
Request Body: <br>

```
  query {
    shows(
        query: "30 Rock"
    )
    {
        tmdbId
        title
        imageUrl
        yearCreated
        mediaType
        rating
        genres
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "shows": [
      {
        "tmdbId": 4608,
        "title": "30 Rock",
        "imageUrl": "https://image.tmdb.org/t/p/w500//k3RbNzPEPW0cmkfkn1xVCTk3Qde.jpg",
        "yearCreated": "2006-10-11",
        "mediaType": "tv",
        "rating": 7.45,
        "genres": [
          "Comedy"
        ]
      },
      {..},
      {..},
    ]
  }
```
</details>

<details close>

<summary>Fetch Show Details by ID</summary>
<br>
  Note: The argument `userId` is only required if the recommendedBy field is present in query <br>
Request Body: <br>

```
  query {
    showDetails(
        tmdbId: 4608
        userId: 1
      	mediaType: "tv"
    )
    {
        tmdbId
        title
        releaseYear
        streamingService {
          logoPath
          providerName
        }
        posterUrl
        genres
        rating
        summary
      	mediaType
        recommendedBy {
                id
                username
                avatarUrl
        }
    	 
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "showDetails": {
      "tmdbId": 4608,
      "title": "30 Rock",
      "releaseYear": "2006",
      "streamingService": [
        {
          "logoPath": "https://image.tmdb.org/t/p/w500/zxrVdFjIjLqkfnwyghnfywTn3Lh.jpg",
          "providerName": "Hulu"
        },
        {..},
        {..}
      ],
      "posterUrl": "https://image.tmdb.org/t/p/w500/k3RbNzPEPW0cmkfkn1xVCTk3Qde.jpg",
      "genres": [
        "Comedy"
      ],
      "rating": 7.45,
      "summary": "Liz Lemon, the head writer...",
      "mediaType": "tv",
      "recommendedBy": [
        {
          "id": "2",
          "username": "martha_stewart",
          "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940448.png"
        },
        {..},
        {..}
      ]
    }
  }
}
```
</details>

- ### Recommendations
<details close>

<summary>Create New Recommendation</summary>
<br>
Request Body: <br>

```
  mutation {
    createRecommendation (
        tmdbId: 4608,
        recommenderId: 1,
        recommendeeId: 2,
        mediaType: "tv"
    )
    {
        id
        tmdbId
        recommenderId
        recommendeeId
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "createRecommendation": {
      "id": "30",
      "tmdbId": 4608,
      "recommenderId": 1,
      "recommendeeId": 2
    }
  }
}
```
</details>

- ### Watchlist Items
<details close>

<summary>Create New Watchlist Item</summary>
<br>
Request Body: <br>

```
  mutation {
    createWatchlistItem (
        tmdbId: 4608,
        userId: 1,
        mediaType: "tv"
    )
    {
        id
        tmdbId
        userId
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "createWatchlistItem": {
      "id": "83",
      "tmdbId": 4608,
      "userId": 1
    }
  }
}
```
</details>

<details close>

<summary>Delete Watchlist Item</summary>
<br>
Request Body: <br>

```
  mutation {
    deleteWatchlistItem (
        id: 83 )
    {
        id
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "deleteWatchlistItem": {
      "id": "83"
    }
  }
}
```
</details>


## Schema

![Final Streamr Schema](https://user-images.githubusercontent.com/108320490/219173283-e30c1d71-01e6-4d8b-b338-a4f64f6af29b.png)



## Contributors
<table>
  <tr>
    <th>James White</th>
    <th>Madeline Mauser</th>
    <th>Sean Culliton</th>
    <th>William Wang</th>
    <th>Kathleen Brandt<br>(Project Manager)</th>
  </tr>
  <tr>
    <td><img src="https://avatars.githubusercontent.com/u/108167041?s=120&v=4"></td>
    <td><img src="https://avatars.githubusercontent.com/u/106927896?width="200" height="115""></td>
    <td><img src="https://avatars.githubusercontent.com/u/108320490?s=120&v=4"></td>
    <td><img src="https://ca.slack-edge.com/T029P2S9M-U03KQFD5WJK-e1166a8fec70-512?width="200" height="115""></td>
    <td><img src="https://avatars.githubusercontent.com/u/96136707?s=120&v=4"></td>
  </tr>

  <tr>
    <td>
      <a href="https://github.com/James-E-White"  rel="nofollow noreferrer">
          <img src="https://i.stack.imgur.com/tskMh.png" alt="github"> Github
        </a><br>
      <a href="https://www.linkedin.com/in/james-ed-wh/" rel="nofollow noreferrer">
    <img src="https://i.stack.imgur.com/gVE0j.png" alt="linkedin"> LinkedIn
        </a>
    </td>
        <td>
       <a href="https://github.com/MadelineMauser" rel="nofollow noreferrer">
            <img src="https://i.stack.imgur.com/tskMh.png" alt="github"> Github
      </a><br>
        <a href="https://www.linkedin.com/in/madeline-mauser-644239245/" rel="nofollow noreferrer">
          <img src="https://i.stack.imgur.com/gVE0j.png" alt="linkedin"> LinkedIn
      </a>
    </td>
        <td>
       <a href="https://github.com/smculliton" rel="nofollow noreferrer">
          <img src="https://i.stack.imgur.com/tskMh.png" alt="github"> Github
      </a><br>
        <a href="https://www.linkedin.com/in/seanculliton" rel="nofollow noreferrer">
          <img src="https://i.stack.imgur.com/gVE0j.png" alt="linkedin"> LinkedIn
      </a>
    </td>
        <td>
       <a href="https://github.com/willjw2" rel="nofollow noreferrer">
            <img src="https://i.stack.imgur.com/tskMh.png" alt="github"> Github
      </a><br>
        <a href="https://www.linkedin.com/in/william-wang-814442240/" rel="nofollow noreferrer">
          <img src="https://i.stack.imgur.com/gVE0j.png" alt="linkedin"> LinkedIn
      </a>
    </td>
        <td>
       <a href="https://github.com/KatBrandt" rel="nofollow noreferrer">
            <img src="https://i.stack.imgur.com/tskMh.png" alt="github"> Github
      </a><br>
        <a href="https://www.linkedin.com/in/katbrandt/" rel="nofollow noreferrer">
          <img src="https://i.stack.imgur.com/gVE0j.png" alt="linkedin"> LinkedIn
      </a>
    </td>
    </tr>
    
</table>

## Gems
- [pry](https://github.com/pry/pry)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [capybara](https://github.com/teamcapybara/capybara)
- [simplecov](https://github.com/simplecov-ruby/simplecov)
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
- [webmock](https://github.com/bblimke/webmock)
- [vcr](https://github.com/vcr/vcr)
- [faraday](https://lostisland.github.io/faraday/usage/)
- [faker](https://github.com/vajradog/faker-rails)
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
- [figaro](https://github.com/laserlemon/figaro)
- [graphql](https://github.com/rmosolgo/graphql-ruby)
- [graphiql](https://github.com/rmosolgo/graphiql-rails)


## Known Issues/Future Goals
Future features could include:
- Ability to add other users as friends.
- Ability to leave individual reviews on shows/movies.
- Additional recommendations based on popularity or at random.


