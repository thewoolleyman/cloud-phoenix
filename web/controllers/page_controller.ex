defmodule CloudPhoenix.PageController do
  use CloudPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
