defmodule ChatSystemWeb.PageController do
  use ChatSystemWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
