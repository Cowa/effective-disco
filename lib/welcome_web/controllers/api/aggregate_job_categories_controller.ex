defmodule WelcomeWeb.API.AggregateJobController do
  use WelcomeWeb, :controller

  alias Welcome.Data.AggregateCategoryByContinent
  alias Welcome.Repo

  import Ecto.Query

  def index(conn, params) do
    query = build_query(params)
    result = Repo.all(query)
    json(conn, to_json(result))
  end

  defp build_query(params) do
    base_query = from(AggregateCategoryByContinent)
    supported_filters = Map.take(params, ["continents", "categories"])

    Enum.reduce(supported_filters, base_query, fn {filter, value}, acc_query ->
      values = String.split(value, ",")

      case filter do
        "continents" -> where(acc_query, [j], j.continent in ^values)
        "categories" -> where(acc_query, [j], j.category_name in ^values)
      end
    end)
  end

  defp to_json(result) do
    Enum.map(result, &%{count: &1.count, category: &1.category_name, continent: &1.continent})
  end
end
