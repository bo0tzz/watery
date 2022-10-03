defmodule Watery.PlantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Watery.Plants` context.
  """

  @doc """
  Generate a plant.
  """
  def plant_fixture(attrs \\ %{}) do
    {:ok, plant} =
      attrs
      |> Enum.into(%{
        frequency: 42,
        last_watered: ~U[2022-10-02 13:13:00Z],
        name: "some name"
      })
      |> Watery.Plants.create_plant()

    plant
  end
end
