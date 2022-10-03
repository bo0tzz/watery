defmodule Watery.Plants.Plant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plants" do
    field :frequency, :integer
    field :last_watered, :utc_datetime
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(plant, attrs) do
    plant
    |> cast(attrs, [:name, :frequency, :last_watered])
    |> validate_required([:name, :frequency])
  end
end
