defmodule Welcome.Repo.Migrations.AddProfessionsTable do
  use Ecto.Migration

  def change do
    create table(:professions) do
      add :name, :string
      add :category_name, :string
    end
  end
end
