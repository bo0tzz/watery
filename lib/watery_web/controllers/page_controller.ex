defmodule WateryWeb.PageController do
  use WateryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
