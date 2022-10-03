defmodule Watery.Plant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plants" do
    field :name, :string
    field :frequency, :integer
    field :last_watered, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(plant, attrs) do
    plant
    |> cast(attrs, [:name, :frequency, :last_watered])
    |> validate_required([:name, :frequency, :last_watered])
  end
end
