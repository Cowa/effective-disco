defmodule Welcome.Repo.Migrations.AddJobOffersTable do
  use Ecto.Migration

  def change
    # Table holding decoded data from lat/long
    create table(:locations) do
      add :continent, :string
      add :country, :string
      add :postcode, :string
      # ... we could add more data if needed (road, house_number...)

      add :latitude, :float
      add :longitude, :float
    end

    create table(:job_offers) do
      add :name, :string
      add :contract_type, :string
      add :profession_id, references(:professions)
      add :location_id, references(:locations)
    end
  end
end
