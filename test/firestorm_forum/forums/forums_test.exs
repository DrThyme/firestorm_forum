defmodule FirestormForum.ForumsTest do
  use FirestormForum.DataCase

  alias FirestormForum.Forums
  alias FirestormForum.Forums.{User, Category, Thread}

  @create_user_attrs %{email: "some email", name: "some name", username: "some username"}
  @update_user_attrs %{email: "some updated email", name: "some updated name", username: "some updated username"}
  @invalid_user_attrs %{email: nil, name: nil, username: nil}

  @create_category_attrs %{title: "some title"}
  @update_category_attrs %{title: "some updated title"}
  @invalid_category_attrs %{title: nil}

  @create_thread_attrs %{title: "some title"}
  @update_thread_attrs %{title: "some updated title"}
  @invalid_thread_attrs %{title: nil}

  def fixture(type, attrs \\ %{})
  def fixture(:user, attrs) do
    {:ok, user} = Forums.create_user(attrs)
    user
  end
  def fixture(:category, attrs) do
    {:ok, category} = Forums.create_category(attrs)
    category
  end
  def fixture(:thread, category, attrs) do
    attrs = Map.put(attrs, :category_id, category.id)
    {:ok, thread} = Forums.create_thread(attrs)
    thread
  end

  test "list_users/1 returns all users" do
    user = fixture(:user, @create_user_attrs)
    assert Forums.list_users() == [user]
  end

  test "get_user! returns the user with given id" do
    user = fixture(:user, @create_user_attrs)
    assert Forums.get_user!(user.id) == user
  end

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Forums.create_user(@create_user_attrs)
    assert user.email == "some email"
    assert user.name == "some name"
    assert user.username == "some username"
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Forums.create_user(@invalid_user_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = fixture(:user, @create_user_attrs)
    assert {:ok, user} = Forums.update_user(user, @update_user_attrs)
    assert %User{} = user
    assert user.email == "some updated email"
    assert user.name == "some updated name"
    assert user.username == "some updated username"
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = fixture(:user, @create_user_attrs)
    assert {:error, %Ecto.Changeset{}} = Forums.update_user(user, @invalid_user_attrs)
    assert user == Forums.get_user!(user.id)
  end

  test "delete_user/1 deletes the user" do
    user = fixture(:user, @create_user_attrs)
    assert {:ok, %User{}} = Forums.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Forums.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = fixture(:user, @create_user_attrs)
    assert %Ecto.Changeset{} = Forums.change_user(user)
  end

  test "list_categories/1 returns all categories" do
    category = fixture(:category, @create_category_attrs)
    assert Forums.list_categories() == [category]
  end

  test "get_category! returns the category with given id" do
    category = fixture(:category, @create_category_attrs)
    assert Forums.get_category!(category.id) == category
  end

  test "create_category/1 with valid data creates a category" do
    assert {:ok, %Category{} = category} = Forums.create_category(@create_category_attrs)
    assert category.title == "some title"
  end

  test "create_category/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Forums.create_category(@invalid_category_attrs)
  end

  test "update_category/2 with valid data updates the category" do
    category = fixture(:category, @create_category_attrs)
    assert {:ok, category} = Forums.update_category(category, @update_category_attrs)
    assert %Category{} = category
    assert category.title == "some updated title"
  end

  test "update_category/2 with invalid data returns error changeset" do
    category = fixture(:category, @create_category_attrs)
    assert {:error, %Ecto.Changeset{}} = Forums.update_category(category, @invalid_category_attrs)
    assert category == Forums.get_category!(category.id)
  end

  test "delete_category/1 deletes the category" do
    category = fixture(:category, @create_category_attrs)
    assert {:ok, %Category{}} = Forums.delete_category(category)
    assert_raise Ecto.NoResultsError, fn -> Forums.get_category!(category.id) end
  end

  test "change_category/1 returns a category changeset" do
    category = fixture(:category, @create_category_attrs)
    assert %Ecto.Changeset{} = Forums.change_category(category)
  end

  test "list_threads/1 returns all threads" do
    category = fixture(:category, @create_category_attrs)
    thread = fixture(:thread, category, @create_thread_attrs)
    assert Forums.list_threads(category) == [thread]
  end

  test "get_thread! returns the thread with given id" do
    category = fixture(:category, @create_category_attrs)
    thread = fixture(:thread, category, @create_thread_attrs)
    assert Forums.get_thread!(category, thread.id) == thread
  end

  test "create_thread/1 with valid data creates a thread" do
    category = fixture(:category, @create_category_attrs)
    attrs = Map.put(@create_thread_attrs, :category_id, category.id)
    assert {:ok, %Thread{} = thread} = Forums.create_thread(attrs)
    assert thread.title == "some title"
  end

  test "create_thread/1 with invalid data returns error changeset" do
    #category = fixture(:category, @create_category_attrs)
    #attrs = Map.put(@invalid_thread_attrs, :category_id, category.id)
    assert {:error, %Ecto.Changeset{}} = Forums.create_thread(@invalid_thread_attrs)
  end

  test "update_thread/2 with valid data updates the thread" do
    category = fixture(:category, @create_category_attrs)
    thread = fixture(:thread, category, @create_thread_attrs)
    assert {:ok, thread} = Forums.update_thread(thread, @update_thread_attrs)
    assert %Thread{} = thread
    assert thread.title == "some updated title"
  end

  test "update_thread/2 with invalid data returns error changeset" do
    category = fixture(:category, @create_category_attrs)
    thread = fixture(:thread, category, @create_thread_attrs)
    assert {:error, %Ecto.Changeset{}} = Forums.update_thread(thread, @invalid_thread_attrs)
    assert thread == Forums.get_thread!(category, thread.id)
  end

  test "delete_thread/1 deletes the thread" do
    category = fixture(:category, @create_category_attrs)
    thread = fixture(:thread, category, @create_thread_attrs)
    assert {:ok, %Thread{}} = Forums.delete_thread(thread)
    assert_raise Ecto.NoResultsError, fn -> Forums.get_thread!(category, thread.id) end
  end

  test "change_thread/1 returns a thread changeset" do
    category = fixture(:category, @create_category_attrs)
    thread = fixture(:thread, category, @create_thread_attrs)
    assert %Ecto.Changeset{} = Forums.change_thread(thread)
  end
end
