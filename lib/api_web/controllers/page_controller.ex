defmodule ApiWeb.PageController do
  use ApiWeb, :controller

  def index(conn, _params) do
    users = []
    json conn, users
  end
end
