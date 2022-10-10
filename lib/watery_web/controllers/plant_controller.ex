defmodule WateryWeb.PlantController do
  use WateryWeb, :controller

  alias Watery.Plants
  alias Watery.Plants.Plant

  def index(conn, _params) do
    conn
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def new(conn, _params) do
    changeset = Plants.change_plant(%Plant{last_watered: DateTime.utc_now()})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plant" => plant_params}) do
    case Plants.create_plant(plant_params) do
      {:ok, plant} ->
        conn
        |> put_flash(:info, "#{plant.name} created successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    plant = Plants.get_plant!(id)
    changeset = Plants.change_plant(plant)
    render(conn, "edit.html", plant: plant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "plant" => plant_params}) do
    plant = Plants.get_plant!(id)

    case Plants.update_plant(plant, plant_params) do
      {:ok, plant} ->
        conn
        |> put_flash(:info, "#{plant.name} updated successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", plant: plant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    plant = Plants.get_plant!(id)
    {:ok, _plant} = Plants.delete_plant(plant)

    conn
    |> put_flash(:info, "#{plant.name} deleted successfully.")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def water(conn, %{"id" => id}) do
    case id do
      "all" -> water_all(conn)
      id -> water_plant(conn, id)
    end
  end

  defp water_all(conn) do
    Plants.water_all()

    conn
    |> put_flash(:info, "All plants have been watered.")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp water_plant(conn, id) do
    {:ok, plant} =
      Plants.get_plant!(id)
      |> Plants.update_plant(%{last_watered: DateTime.utc_now()})

    conn
    |> put_flash(:info, "#{plant.name} has been watered.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
