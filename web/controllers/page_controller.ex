defmodule CfPhoenix.PageController do
  use CfPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
