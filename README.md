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
