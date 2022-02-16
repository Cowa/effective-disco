defmodule Welcome do
  alias Welcome.Data.AggregateCategoryByContinent
  alias Welcome.Repo

  import Ecto.Query

  def category_by_continent do
    Repo.all(from(AggregateCategoryByContinent))
  end
end
