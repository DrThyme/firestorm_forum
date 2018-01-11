defmodule FirestormForumWeb.CategoryView do
  use FirestormForumWeb, :view

  def category_link(conn, category) do
    link category.title, to: category_path(conn, :show, category.id)
  end
end
