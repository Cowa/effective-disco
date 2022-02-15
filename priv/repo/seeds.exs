alias NimbleCSV.RFC4180, as: CSV
alias Welcome.Repo
alias Welcome.Data.{JobOffers, Profession}

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
|> Enum.each(fn [profession_id, contract_type, name, office_latitude, office_longitude] ->
  [profession_id, contract_type, name, office_latitude, office_longitude]

  # @todo decode geopoint to create a new location and create the job_offer
end)
