# Effective disco

## WTTJ Technical test

## How to run

  * Install dependencies with `mix deps.get`
  * Spawn a pre-configurated a PostgresSQL DB with `docker-compose up`
  * Create, migrate and seed your database with `mix ecto.setup`
    * `priv/repo/seeds.exs` to see how the database is populated with CSVs
  * Run job categories aggregated by continent with `mix aggregate_categories_by_continent`
  * Start server with `mix phx.server`
  * API is on `http://localhost:4000/api/aggregate_job`
    * supported params: `continents` and `categories` (as string arrays)
    * ex: `GET /api/aggregate_job?continents=africa,europe&categories=tech`

## Question: scaling?

To handle 1000 new job offers every second, the bottleneck would be the reverse geocoding, especially if we need to call an external API (here I just used spatial geometry though). So I would insert new job offers as they arrived with a "non-decoded" location and do the reverse geocoding asynchronously by spawning a new process. This way, creating a new job offer would be very snappy only to have a little delay to see the decoded location.

To have the jobs aggregated in near real-time, I would turn the current `aggregate_categories_by_continent` view into a materialized view. This will acts as a cache to have the result with no computation at all. But then we have to refresh the materialized view to update its data. I would set up a cron that refresh it every X seconds. The higher X is, the lesser the view is near real-time, but the lesser is power consumption too. But it would be easily possible to add a real-time feel if the UI is using some tweening effects on counters (ex: if X is 10, UI can tween counters from previous values to new values over 10 seconds, until new updated data arrives and repeat).

## Informations

### Geocoding

I used spatial geometry to find on which continent is a lat/long position. But I couldn't find any data source containing their polygons boundaries. So I created them manually and... well, they are clearly not accurate enough for real use ;)

I first wanted to use an external API to do the reverse geocoding by using Open Street Map API. But I discovered that the continent data was not always there. And Google Geocoding free plan only covers 2,500 requests per day so it was clearly not possible.

### Why Elixir/Phoenix?

1 - I really like Elixir and Phoenix. I have been using them for 4 years. So it's clearly the environment where I am the most comfortable right now.

2 - The job offer is mainly for doing Elixir ;)

3 - Elixir and Phoenix are a great fit for Web development in general. The concurrent and distribution natures of BEAM make them a great platform to build scalable and resilient systems.

### Why PostgreSQL?

For relational data I always choose by default PostgreSQL. It's the database I'm the most comfortable with and it has plenty of useful features.

For example I used a `VIEW` to show the aggregated data by continent. As it's just data from the database, it makes sense to let PostgreSQL do the job instead of doing the query manually from the Elixir-side. This way, anyone with access to the DB (ex: Data teams) can have this view too. Plus it allows to do the filtering as if it was just a simple table:

`SELECT * FROM aggregate_categories_by_continent WHERE continent = "europe"`
