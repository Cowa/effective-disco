defmodule Welcome.Data.Profession do
  use Ecto.Schema

  schema "professions" do
    field :name, :string
    field :category_name, :string
  end
end
