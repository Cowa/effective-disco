alias NimbleCSV.RFC4180, as: CSV
alias Welcome.Data.{JobOffer, Location, Profession}
alias Welcome.GeoCoding.Continents
alias Welcome.Repo

# Populate 'professions' table with given data
File.stream!("priv/data/technical-test-professions.csv")
|> CSV.parse_stream()
|> Enum.each(fn [id, name, category] ->
  Repo.insert!(%Profession{id: String.to_integer(id), name: name, category_name: category},
    on_conflict: :replace_all,
    conflict_target: :id
  )
end)

# Populate 'job_offers' table with given data
File.stream!("priv/data/technical-test-jobs.csv")
|> CSV.parse_stream()
|> Enum.map(fn
  # No office location, default to unknown
  job_data = [_, _, _, "", ""] ->
    # Upsert
    location =
      Repo.insert!(%Location{continent: "unknown"},
        on_conflict: [set: [latitude: nil, longitude: nil]],
        conflict_target: [:latitude, :longitude]
      )

    {location, job_data}

  job_data = [_, _, _, lat, long] ->
    [lat, long] = Enum.map([lat, long], &String.to_float/1)

    location =
      case Continents.find_continent(lat, long) do
        nil ->
          %Location{continent: "unknown", latitude: lat, longitude: long}

        continent ->
          continent_name = continent |> elem(0) |> Atom.to_string()
          %Location{continent: continent_name, latitude: lat, longitude: long}
      end
      |> Repo.insert!(
        on_conflict: [set: [latitude: lat, longitude: long]],
        conflict_target: [:latitude, :longitude]
      )

    {location, job_data}
end)
# Create job offers linked to a location and profession
|> Enum.each(fn {location, [profession_id, contract_type, name, _lat, _long]} ->
  # Some job offer may not have a profession id
  profession_id = unless profession_id == "", do: String.to_integer(profession_id), else: nil

  Repo.insert!(%JobOffer{
    location_id: location.id,
    profession_id: profession_id,
    name: name,
    contract_type: contract_type
  })
end)
