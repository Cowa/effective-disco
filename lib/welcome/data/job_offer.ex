defmodule Welcome.Data.JobOffer do
  use Ecto.Schema

  alias Welcome.Data.{Location, Profession}

  schema "job_offers" do
    field :name, :string
    field :contract_type, :string

    belongs_to :profession, Profession
    belongs_to :location, Location
  end
end
