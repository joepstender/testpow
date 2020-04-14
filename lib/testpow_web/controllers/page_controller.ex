defmodule TestpowWeb.PageController do
  use TestpowWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
