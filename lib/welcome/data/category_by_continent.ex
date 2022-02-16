defmodule Welcome.Data.CategoryByContinent do
  use Ecto.Schema

  @primary_key false
  schema "job_categories_by_continent" do
    field :continent, :string
    field :category_name, :string
    field :count, :integer
  end
end
