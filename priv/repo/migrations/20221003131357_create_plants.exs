defmodule Watery.Repo.Migrations.CreatePlants do
  use Ecto.Migration

  def change do
    create table(:plants) do
      add :name, :string
      add :frequency, :integer
      add :last_watered, :utc_datetime

      timestamps()
    end
  end
end
