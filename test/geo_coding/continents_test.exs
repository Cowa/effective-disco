defmodule Welcome.GeoCoding.ContinentsTest do
  use ExUnit.Case

  alias Welcome.GeoCoding.Continents

  test "should find the rigth continent given a latitude and a longitude" do
    # Inverted lat long??
    # München
    assert_continent(48.1392154, 11.5781413, :europe)
    # Paris
    assert_continent(48.885247, 2.3566441, :europe)
    # London
    assert_continent(51.4975114, -0.1474062, :europe)
    # Moscow
    assert_continent(55.717592, 37.601485, :asia)
    # Abuja
    assert_continent(9.057314, 7.406093, :africa)
    # Brazil
    assert_continent(-8.193432, -53.005712, :south_america)
    # Kansas
    assert_continent(38.148903, -98.552500, :north_america)
  end

  defp assert_continent(lat, long, expected_continent) do
    {continent, _} = Continents.find_continent(lat, long)
    assert continent == expected_continent
  end
end
