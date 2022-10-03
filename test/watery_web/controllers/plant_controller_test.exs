defmodule WateryWeb.PlantControllerTest do
  use WateryWeb.ConnCase

  import Watery.PlantsFixtures

  @create_attrs %{frequency: 42, last_watered: ~U[2022-10-02 13:13:00Z], name: "some name"}
  @update_attrs %{frequency: 43, last_watered: ~U[2022-10-03 13:13:00Z], name: "some updated name"}
  @invalid_attrs %{frequency: nil, last_watered: nil, name: nil}

  describe "index" do
    test "lists all plants", %{conn: conn} do
      conn = get(conn, Routes.plant_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Plants"
    end
  end

  describe "new plant" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.plant_path(conn, :new))
      assert html_response(conn, 200) =~ "New Plant"
    end
  end

  describe "create plant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.plant_path(conn, :create), plant: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.plant_path(conn, :show, id)

      conn = get(conn, Routes.plant_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Plant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.plant_path(conn, :create), plant: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Plant"
    end
  end

  describe "edit plant" do
    setup [:create_plant]

    test "renders form for editing chosen plant", %{conn: conn, plant: plant} do
      conn = get(conn, Routes.plant_path(conn, :edit, plant))
      assert html_response(conn, 200) =~ "Edit Plant"
    end
  end

  describe "update plant" do
    setup [:create_plant]

    test "redirects when data is valid", %{conn: conn, plant: plant} do
      conn = put(conn, Routes.plant_path(conn, :update, plant), plant: @update_attrs)
      assert redirected_to(conn) == Routes.plant_path(conn, :show, plant)

      conn = get(conn, Routes.plant_path(conn, :show, plant))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, plant: plant} do
      conn = put(conn, Routes.plant_path(conn, :update, plant), plant: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Plant"
    end
  end

  describe "delete plant" do
    setup [:create_plant]

    test "deletes chosen plant", %{conn: conn, plant: plant} do
      conn = delete(conn, Routes.plant_path(conn, :delete, plant))
      assert redirected_to(conn) == Routes.plant_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.plant_path(conn, :show, plant))
      end
    end
  end

  defp create_plant(_) do
    plant = plant_fixture()
    %{plant: plant}
  end
end
