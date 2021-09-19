# README

# Setup && running the application

Before you run the application for the first time, you must create the database, load the schema and initialize it with the seed data:

```
docker-compose run backend rails db:setup
```

## Running

Running the app (and navigate to `http://localhost:8080`):

```
docker-compose up --build
```

Running backend RSpec tests:

```
docker-compose run backend rspec
```
