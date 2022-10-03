defmodule Watery.Plants.Plant do
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
    |> validate_required([:name, :frequency])
    |> validate_number(:frequency, greater_than: 0)
    |> validate_change(:last_watered, fn :last_watered, last_watered ->
      case DateTime.compare(last_watered, DateTime.utc_now()) do
        :lt -> []
        _ -> [last_watered: "cannot be in the future"]
      end
    end)
  end
end
