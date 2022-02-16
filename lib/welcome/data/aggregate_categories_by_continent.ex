defmodule Welcome.Data.AggregateCategoryByContinent do
  use Ecto.Schema

  @primary_key false
  schema "aggregate_categories_by_continent" do
    field :continent, :string
    field :category_name, :string
    field :count, :integer
  end
end
