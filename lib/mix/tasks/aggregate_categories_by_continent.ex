defmodule Mix.Tasks.AggregateCategoriesByContinent do
  use Mix.Task

  def run(_args) do
    Application.ensure_all_started(:welcome)

    Welcome.category_by_continent() |> IO.inspect()
  end
end
