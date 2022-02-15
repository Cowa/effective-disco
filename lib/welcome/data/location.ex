defmodule Welcome.Data.Location do
  use Ecto.Schema

  schema "locations" do
    field :continent, :string
    field :country, :string
    field :postcode, :string

    field :latitude, :float
    field :longitude, :float
  end
end
