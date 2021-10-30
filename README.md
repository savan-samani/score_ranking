# Top Score Ranking

This application only implemented APIs, will be used to keep scores for a group of player.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine with Docker for development and testing purposes.

### Prerequisites

* Ruby version

  - Ruby-3.0.1

* Rails vesrion

  - Rails-6.1.3

* Testing framework
  - RSpec

# Installation

 1. [Manual](#manual)
 2. [With Docker](#with-docker)

A step by step series of examples that tell you how to get a development env running.

## Manual

- Clone this repository

```
$ git clone https://github.com/savan-samani/score_ranking.git
```

- Install a compatible version of PostgreSQL

```
$ brew install postgresql@12.3
```

- Move to the `score_ranking` directory from your terminal

```
$ cd score_ranking
```

- Initialize a new gemset (if using RVM) then install bundler

```
$ gem install bundler
```

- Install the application dependencies

```
$ bundle install
```

#### Database Configuration

*PostgreSQL* used as database for this application.
> Make sure PostgreSQL is installed in your machine and you have setup the  `database.yml` file correctly

- Database creation

```
$ bundle exec rails db:create
```

- Tables migration and preparing for tests

```
$ bundle exec rails db:migrate
$ bundle exec rails db:test:prepare
```

- check the *db/schema.rb* after migration completed successfully

#### Running Tests

Test cases written using *RSpec*

Run test cases using this command

```
$ bundle exec rspec
```

All the tests should be *GREEN* to pass all test cases

#### Running Application

- Starting application

> Make sure you are in the application folder and already installed application dependencies

```
$ rails server
```

- Check the application on browser, open the any browser of your choice and hit the following in the browser url *http://localhost:3000/*

> Make sure server listen on port 3000

```
localhost:3000
```

## With Docker

- Build docker image
> Make sure you are in the application folder and already installed [Docker](https://docs.docker.com/get-docker/) & [Docker Compose](https://docs.docker.com/compose/install/) in your machine.

```
$ docker-compose build
```

- Install the application dependencies

```
$ docker-compose run web bundle exec bundle install
```

#### Database Configuration

- Start *PostgreSQL* docker image

```
$ docker-compose up -d db
```

- Checking *PostgreSQL* is running or not

```
$ docker-compose ps

Result should be like this

Name                       Command              State               Ports
---------------------------------------------------------------------------------------
score_ranking_db_1  docker-entrypoint.sh postgres   Up      0.0.0.0:5432->5432/tcp
```

- Database creation

```
$ docker-compose run web rails db:create
```

- Tables migration and preparing for tests

```
$ docker-compose run web rails db:migrate
$ docker-compose run web rails db:test:prepare
```
#### Running Tests

Run test cases in docker image using this command

```
$ docker-compose run web rspec
```
#### Running Application

- Starting application

```
$ docker-compose up web
```

## APIs documentation with [Postman](https://www.postman.com/)
POST Create Score
```
http://localhost:3000/api/scores
```

```
{
    "score": {
        "name": "bbb", // Required: true, Type: String, Desc: Name of player
        "score_point": 10, // Required: true, Type: Integer, Desc: Player score
        "score_at": "2021-05-19T11:54:43.000+09:00" // Required: true, Type: DateTime, Desc: Score record time
    }
}
```
GET Get Score
```
http://localhost:3000/api/scores/16
```


DELDelete Score
```
http://localhost:3000/api/scores/16
```

GET List Scores
```
http://localhost:3000/api/scores?name=aaa&after_score_date=2021-05-14&before_score_date=2021-05-19&limit=10&offset=0
```

GETPlayer profile
```
http://localhost:3000/api/players/1
```


## Author

* **Savan Samani** - [GitHub profile](https://github.com/savan-samani)
