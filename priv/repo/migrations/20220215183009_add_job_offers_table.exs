defmodule Welcome.Repo.Migrations.AddJobOffersTable do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :continent, :string, default: "Unknown"

      add :latitude, :float
      add :longitude, :float
    end

    create index(:locations, [:latitude, :longitude], unique: true)

    create table(:job_offers) do
      add :name, :string
      add :contract_type, :string
      add :profession_id, references(:professions)
      add :location_id, references(:locations)
    end
  end
end
