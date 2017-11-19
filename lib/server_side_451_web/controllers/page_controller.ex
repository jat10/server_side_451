defmodule ServerSide451Web.PageController do
  use ServerSide451Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
