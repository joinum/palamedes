defmodule LinkerWeb.RedirectLiveTest do
  use LinkerWeb.ConnCase

  import Phoenix.LiveViewTest
  import Linker.ShortenerFixtures

  @create_attrs %{link: "some link", name: "some name", slug: "some slug", url: "some url", visits: 42}
  @update_attrs %{link: "some updated link", name: "some updated name", slug: "some updated slug", url: "some updated url", visits: 43}
  @invalid_attrs %{link: nil, name: nil, slug: nil, url: nil, visits: nil}

  defp create_redirect(_) do
    redirect = redirect_fixture()
    %{redirect: redirect}
  end

  describe "Index" do
    setup [:create_redirect]

    test "lists all redirects", %{conn: conn, redirect: redirect} do
      {:ok, _index_live, html} = live(conn, Routes.redirect_index_path(conn, :index))

      assert html =~ "Listing Redirects"
      assert html =~ redirect.link
    end

    test "saves new redirect", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.redirect_index_path(conn, :index))

      assert index_live |> element("a", "New Redirect") |> render_click() =~
               "New Redirect"

      assert_patch(index_live, Routes.redirect_index_path(conn, :new))

      assert index_live
             |> form("#redirect-form", redirect: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#redirect-form", redirect: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.redirect_index_path(conn, :index))

      assert html =~ "Redirect created successfully"
      assert html =~ "some link"
    end

    test "updates redirect in listing", %{conn: conn, redirect: redirect} do
      {:ok, index_live, _html} = live(conn, Routes.redirect_index_path(conn, :index))

      assert index_live |> element("#redirect-#{redirect.id} a", "Edit") |> render_click() =~
               "Edit Redirect"

      assert_patch(index_live, Routes.redirect_index_path(conn, :edit, redirect))

      assert index_live
             |> form("#redirect-form", redirect: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#redirect-form", redirect: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.redirect_index_path(conn, :index))

      assert html =~ "Redirect updated successfully"
      assert html =~ "some updated link"
    end

    test "deletes redirect in listing", %{conn: conn, redirect: redirect} do
      {:ok, index_live, _html} = live(conn, Routes.redirect_index_path(conn, :index))

      assert index_live |> element("#redirect-#{redirect.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#redirect-#{redirect.id}")
    end
  end

  describe "Show" do
    setup [:create_redirect]

    test "displays redirect", %{conn: conn, redirect: redirect} do
      {:ok, _show_live, html} = live(conn, Routes.redirect_show_path(conn, :show, redirect))

      assert html =~ "Show Redirect"
      assert html =~ redirect.link
    end

    test "updates redirect within modal", %{conn: conn, redirect: redirect} do
      {:ok, show_live, _html} = live(conn, Routes.redirect_show_path(conn, :show, redirect))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Redirect"

      assert_patch(show_live, Routes.redirect_show_path(conn, :edit, redirect))

      assert show_live
             |> form("#redirect-form", redirect: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#redirect-form", redirect: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.redirect_show_path(conn, :show, redirect))

      assert html =~ "Redirect updated successfully"
      assert html =~ "some updated link"
    end
  end
end
