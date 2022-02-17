# Effective disco

## WTTJ Technical test

## How to run

  * Install dependencies with `mix deps.get`
  * Spawn a pre-configurated a PostgresSQL DB with `docker-compose up`
  * Create, migrate and seed your database with `mix ecto.setup`
  * Run job categories aggregated by continent with `mix aggregate_categories_by_continent`
  * Start server with `mix phx.server`
  * API is on `http://localhost:4000/api/aggregate_job`
    * supported params: `continents` and `categories` (as string arrays)
    * ex: `GET /api/aggregate_job?continents=africa,europe&categories=tech`

## Question: scaling?

To handle 1000 new job offers every second, the bottleneck would be the reverse geocoding, especially if we need to call an external API (here I just used spatial geometry though). So I would insert new job offers as they arrived with a "non-decoded" location and do the reverse geocoding asynchronously by spawning a new process. This way, creating a new job offer would be very snappy only to have a little delay to see the decoded location.

To have the jobs aggregated in near real-time, I would turn the current `aggregate_categories_by_continent` view into a materialized view. This will acts as a cache to have the result with no computation at all. But then we have to refresh the materialized view to update its data. I would set up a cron that refresh it every X seconds. The higher X is, the lesser the view is near real-time, but the lesser is power consumption too. But it would be easily possible to add real-time feel if the UI is using some tweening effects on counters (ex: if X is 10, UI can tween counters from previous values to new values over 10 seconds, until new updated data arrives and repeat).
