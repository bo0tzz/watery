defmodule Watery.PlantsTest do
  use Watery.DataCase

  alias Watery.Plants

  describe "plants" do
    alias Watery.Plants.Plant

    import Watery.PlantsFixtures

    @invalid_attrs %{frequency: nil, last_watered: nil, name: nil}

    test "list_plants/0 returns all plants" do
      plant = plant_fixture()
      assert Plants.list_plants() == [plant]
    end

    test "get_plant!/1 returns the plant with given id" do
      plant = plant_fixture()
      assert Plants.get_plant!(plant.id) == plant
    end

    test "create_plant/1 with valid data creates a plant" do
      valid_attrs = %{frequency: 42, last_watered: ~U[2022-10-02 13:13:00Z], name: "some name"}

      assert {:ok, %Plant{} = plant} = Plants.create_plant(valid_attrs)
      assert plant.frequency == 42
      assert plant.last_watered == ~U[2022-10-02 13:13:00Z]
      assert plant.name == "some name"
    end

    test "create_plant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Plants.create_plant(@invalid_attrs)
    end

    test "update_plant/2 with valid data updates the plant" do
      plant = plant_fixture()
      update_attrs = %{frequency: 43, last_watered: ~U[2022-10-03 13:13:00Z], name: "some updated name"}

      assert {:ok, %Plant{} = plant} = Plants.update_plant(plant, update_attrs)
      assert plant.frequency == 43
      assert plant.last_watered == ~U[2022-10-03 13:13:00Z]
      assert plant.name == "some updated name"
    end

    test "update_plant/2 with invalid data returns error changeset" do
      plant = plant_fixture()
      assert {:error, %Ecto.Changeset{}} = Plants.update_plant(plant, @invalid_attrs)
      assert plant == Plants.get_plant!(plant.id)
    end

    test "delete_plant/1 deletes the plant" do
      plant = plant_fixture()
      assert {:ok, %Plant{}} = Plants.delete_plant(plant)
      assert_raise Ecto.NoResultsError, fn -> Plants.get_plant!(plant.id) end
    end

    test "change_plant/1 returns a plant changeset" do
      plant = plant_fixture()
      assert %Ecto.Changeset{} = Plants.change_plant(plant)
    end
  end
end
