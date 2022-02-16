defmodule WelcomeWeb.API.AggregateJobControllerTest do
  use WelcomeWeb.ConnCase

  alias Welcome.Data.{JobOffer, Location, Profession}
  alias Welcome.Repo

  setup do
    # Create some data
    europe_location =
      Repo.insert!(%Location{continent: "europe", latitude: 48.1392154, longitude: 11.5781413})

    africa_location =
      Repo.insert!(%Location{continent: "africa", latitude: 9.057314, longitude: 7.406093})

    south_america_location =
      Repo.insert!(%Location{
        continent: "south_america",
        latitude: -8.193432,
        longitude: -53.005712
      })

    north_america_location =
      Repo.insert!(%Location{
        continent: "north_america",
        latitude: 38.148903,
        longitude: -98.552500
      })

    tech_profession = Repo.insert!(%Profession{category_name: "tech"})
    retail_profession = Repo.insert!(%Profession{category_name: "retail"})
    business_profession = Repo.insert!(%Profession{category_name: "business"})

    jobs = [
      Repo.insert!(%JobOffer{profession_id: tech_profession.id, location_id: europe_location.id}),
      Repo.insert!(%JobOffer{profession_id: tech_profession.id, location_id: europe_location.id}),
      Repo.insert!(%JobOffer{profession_id: retail_profession.id, location_id: africa_location.id}),
      Repo.insert!(%JobOffer{
        profession_id: business_profession.id,
        location_id: south_america_location.id
      }),
      Repo.insert!(%JobOffer{
        profession_id: tech_profession.id,
        location_id: north_america_location.id
      })
    ]

    {:ok, %{jobs: jobs}}
  end

  test "GET /api/aggregate_job with no filters", %{conn: conn, jobs: _jobs} do
    conn = get(conn, "/api/aggregate_job")
    result = json_response(conn, 200)

    assert result == [
             %{"category" => "retail", "continent" => "africa", "count" => 1},
             %{"category" => "tech", "continent" => "europe", "count" => 2},
             %{"category" => "tech", "continent" => "north_america", "count" => 1},
             %{"category" => "business", "continent" => "south_america", "count" => 1}
           ]
  end

  test "GET /api/aggregate_job with filters", %{conn: conn, jobs: _jobs} do
    # With non-array filters
    conn = get(conn, "/api/aggregate_job?continents=africa")
    result = json_response(conn, 200)

    assert result == [
             %{"category" => "retail", "continent" => "africa", "count" => 1}
           ]

    conn = get(conn, "/api/aggregate_job?categories=tech")
    result = json_response(conn, 200)

    assert result == [
             %{"category" => "tech", "continent" => "europe", "count" => 2},
             %{"category" => "tech", "continent" => "north_america", "count" => 1}
           ]

    # With array filter
    conn = get(conn, "/api/aggregate_job?categories=tech,business")
    result = json_response(conn, 200)

    assert result == [
             %{"category" => "tech", "continent" => "europe", "count" => 2},
             %{"category" => "tech", "continent" => "north_america", "count" => 1},
             %{"category" => "business", "continent" => "south_america", "count" => 1}
           ]
  end
end
