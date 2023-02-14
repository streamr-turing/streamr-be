<div align="center">
  <h1>Streamr API</h1>
  <h1>-WIP-</h1>
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

This repo is the back end service of a project built by students at [Turing School of Software and Design](https://turing.edu/). You can find the Front End repo [HERE](https://github.com/streamr-turing/streamr-fe).



## Learning Goals
[Project Spec](https://mod4.turing.edu/projects/capstone/)

This project's goal was to synthesize the knowledge accumulated over the course of the Turing web development program in order to produce a complete web application from a student-led project idea, focusing on Service-Oriented Architecture with separate front end and back end teams. Communication was crucial as each team was composed of students who were trained solely for their respective side of the stack. As part of the project requirements, a stretch tech had to be learned and incorporated into both ends of the application. GraphQL was the chosen stretch tech for this application. Agile methodologies were also implemented to manage the project during the two-week time period given to complete the Minimum Viable Product.
The back-end handles the project's API consumption and acts as the interface to the project's database.

## Setup

1. Clone the repository
2. Navigate into the root directory
3. Install gem packages: `bundle install`
4. Setup the database: `rails db:{drop,create,migrate}`
6. Run `rails s` to start the server
7. You may run the RSpec test suite locally with `bundle exec rspec`

## Endpoints
Back End Server: https://streamr_be.herokuapp.com/

This application uses GraphQL and therefore all requests should be sent to the base path `https://streamr-be.herokuapp.com/graphql` with the appropriate query in the request body.

- ### Fetch Users
<details close>
<summary>Get All Users in the Database</summary>
<br>


Returns a list of all users in the database. User fields supported:
- id
- name

Request: <br>
```
GET /api/v1/disease_cases?state=#{state_name}
```
Example:
[Get Disease Cases in Georgia](https://epitrac-be.herokuapp.com/api/v1/disease_cases?state=GEORGIA)

JSON Response Example:
```json
{
    "data": [
        {
            "id": "20225200032",
            "type": "disease_case",
            "attributes": {
                "state": "GEORGIA",
                "year": "2022",
                "current_week": 52,
                "disease": "Anthrax",
                "cumulative_current": 0,
                "cumulative_last": 0,
                "coordinates": [
                    -84.39111,
                    33.74831
                ],
                "id": "20225200032",
                "current_week_cases": 0
              }
        },
        {
            "id": "20225200102",
            "type": "disease_case",
            "attributes": {
                "state": "GEORGIA",
                "year": "2022",
                "current_week": 52,
                "disease": "Arboviral diseases, Chikungunya virus disease",
                "cumulative_current": 0,
                "cumulative_last": 0,
                "coordinates": [
                    -84.39111,
                    33.74831
                ],
                "id": "20225200102",
                "current_week_cases": 0
              }
        },
        {...},
        {...},
        ]
}

```
</details>

<details close>
<summary>Get All Disease Cases for Current Week</summary>
<br>


Returns a list of diseases in all states for the most recent MMWR week recorded in the [NNDSS Weekly Dataset](https://data.cdc.gov/NNDSS/NNDSS-Weekly-Data/x9gk-5huc).

Data Sourced from the [NNDSS Weekly Data API](https://dev.socrata.com/foundry/data.cdc.gov/x9gk-5huc).

Request: <br>
```
GET /api/v1/disease_cases
```
Example: 
[Get All Disease Cases For Latest Week](https://epitrac-be.herokuapp.com/api/v1/disease_cases)

JSON Response Example:
```json
{
    "data": [
        {
            "id": "20225200003",
            "type": "disease_case",
            "attributes": {
                "state": "CONNECTICUT",
                "year": "2022",
                "current_week": 52,
                "disease": "Anthrax",
                "cumulative_current": 0,
                "cumulative_last": 0,
                "coordinates": [
                    -72.67399,
                    41.76376
                ],
                "id": "20225200003",
                "current_week_cases": 0
            }
        },
        {
            "id": "20225200004",
            "type": "disease_case",
            "attributes": {
                "state": "MAINE",
                "year": "2022",
                "current_week": 52,
                "disease": "Anthrax",
                "cumulative_current": 0,
                "cumulative_last": 0,
                "coordinates": [
                    -69.77631,
                    44.31804
                ],
                "id": "20225200004",
                "current_week_cases": 0
            }
        },
        {...},
        {...},
    ]
}
```
</details>

- ### Articles
<details close>

<summary>Get Articles for a Disease</summary>
<br>


Returns a list of articles related to that disease.

Data sourced from [Science Clips](https://dev.socrata.com/foundry/data.cdc.gov/biid-68vb).

Request: <br>
```
GET /api/v1/articles?disease=#{disease}
```
Example: 
[Get Articles Related to Anthrax](https://epitrac-be.herokuapp.com/api/v1/articles?disease=anthrax)

JSON Response Example:
```json
{
 "data": [
        {
            "id": "1076",
            "type": "article",
            "attributes": {
                "article_id": "1076",
                "author": "de Oliveira, F. F. M. M., S.;Gonti, S.;Brey, R. N.;Li, H.;Schiffer, J.;Casadevall, A.;Bann, J. G.",
                "title": "Binding of the von Willebrand factor a domain of capillary morphogenesis protein 2 to anthrax protective antigen vaccine reduces immunogenicity in mice",
                "year": "2020",
                "date": "15-01",
                "isbn_issn": "2379-5042",
                "keywords": "anthrax:antigen processing:immunization:protein stability",
                "abstract": "Protective antigen (PA) is a component of anthrax toxin ....",
                "url": "https://www.ncbi.nlm.nih.gov/pubmed/31941807",
                "doi": "10.1128/mSphere.00556-19"
            }
        },
        {
            "id": "1380",
            "type": "article",
            "attributes": {
                "article_id": "1380",
                "author": "Hupert, N. W., D.,  Cuomo, J.,  Hollingsworth, E.,  Neukermans, K.,  Xiong, W.,",
                "title": "Predicting hospital surge after a large-scale anthrax attack: a model-based analysis of CDC's cities readiness initiative prophylaxis recommendations",
                "year": "2009",
                "date": "Jul-Aug",
                "isbn_issn": "0272-989X (Print)",
                "keywords": null,
                "abstract": "BACKGROUND: A CRI-compliant prophylaxis...",
                "url": "http://mdm.sagepub.com/cgi/reprint/29/4/424",
                "doi": "10.1177/0272989X09341389"
            }      
        },
        {...},
        {...},
        ...
        ...
      ]
}
```
</details>

<details close>
<summary> Save an Article for a User </summary>
<br>

Request: <br>
```
POST /api/v1/user_articles?user_id=#{user_id}&article_id=#{article_id}
```

JSON Response Example:
```json
{
 "data": {
        "id": "10",
        "type": "user_article",
        "attributes": {
            "user_id": 1,
            "article_id": 88
        }
    }
}
```
</details>

<details close>
<summary> Delete a Saved Article for a User </summary>
<br>

Request: <br>
```
DELETE /api/v1/user_articles/:id
```

JSON Response Example:
```json
{
    "message": "The article was successfully deleted from your dashboard"
}
```
</details>

<details close>
<summary> Get a Users Saved Articles </summary>
<br>


Request: <br>
```
GET /api/v1/user_articles/?user_id=#{user_id}
```

JSON Response Example:
```json
{
    "data": [
        {
            "id": "1",
            "type": "article",
            "attributes": {
                "article_id": "50",
                "author": "Johnson, T. L. G., C. B., Maes, S. E., Hojgaard, A., Fleshman, A., Boegler, K. A., Delory, M. J., Slater, K. S., Karpathy, S. E., Bjork, J. K., Neitzel, D. F., Schiffman, E. K., Eisen, R. J.,",
                "title": "Prevalence and distribution of seven human pathogens in host-seeking Ixodes scapularis (Acari: Ixodidae) nymphs in Minnesota, USA",
                "year": "2018",
                "date": "20-07",
                "isbn_issn": "1877-959x",
                "keywords": "Anaplasmosis:Babesiosis:Coinfection:Density of infected nymphs (DIN):Lyme disease:Nymphal infection prevalence (NIP)",
                "abstract": "In the north-central United States,...",
                "url": "https://www.ncbi.nlm.nih.gov/pubmed/30055987",
                "doi": "10.1016/j.ttbdis.2018.07.009"
            }
        },
        {...}
    ]
}



```
</details>

- ### Disease Info
<details close>
<summary> Get Information for all Diseases </summary>
<br>


Request: <br>
```
GET /api/v1/disease_info
```
Example:
[Get information for all diseases](https://epitrac-be.herokuapp.com/api/v1/disease_info)

JSON Response Example:
```json
{
    "data": [
        {
            "id": "1",
            "type": "disease_info",
            "attributes": {
                "disease": "Anthrax",
                "short_name": "Anthrax",
                "information": "Anthrax is a serious infectious disease...",
                "link": "https://www.cdc.gov/anthrax/"
            }
        },
        {
            "id": "2",
            "type": "disease_info",
            "attributes": {
                "disease": "Arboviral diseases, Chikungunya virus disease",
                "short_name": "Chikungunya",
                "information": "Chikungunya virus is spread to people...",
                "link": "https://www.cdc.gov/chikungunya/index.html"
            }
        },
        {....}
    ]
}
```
</details>

<details close>
<summary> Get Information for One Disease </summary>
<br>


Request: <br>
```
GET /api/v1/disease_info?disease=#{disease}
```
Example:
[Get Information for Anthrax](https://epitrac-be.herokuapp.com/api/v1/disease_info?disease=anthrax)

JSON Response Example:
```json
{
    "data": [
        {
            "id": "1",
            "type": "disease_info",
            "attributes": {
                "disease": "Anthrax",
                "short_name": "Anthrax",
                "information": "Anthrax is a serious infectious disease...",
                "link": "https://www.cdc.gov/anthrax/"
            }
        }
    ]
}
```
</details>

## Schema

-WIP-

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
    <td><img src="https://avatars.githubusercontent.com/u/106927896?s=120&v=4"></td>
    <td><img src="https://avatars.githubusercontent.com/u/108320490?s=120&v=4"></td>
    <td><img src="https://avatars.githubusercontent.com/u/110333328?s=120&v=4"></td>
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

## Known Issues/Future Goals
Future features could include:
- WIP




This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
