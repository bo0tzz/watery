defmodule WateryWeb.PageController do
  use WateryWeb, :controller

  def index(conn, _params) do
    plants = Watery.Plants.list_plants_ordered()
    render(conn, "index.html", plants: plants)
  end
end
