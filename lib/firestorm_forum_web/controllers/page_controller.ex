defmodule FirestormForumWeb.PageController do
  use FirestormForumWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
