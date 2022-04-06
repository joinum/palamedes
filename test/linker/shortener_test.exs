defmodule Linker.ShortenerTest do
  use Linker.DataCase

  alias Linker.Shortener

  describe "links" do
    alias Linker.Shortener.Link

    import Linker.ShortenerFixtures

    @invalid_attrs %{attention: nil, clicks: nil, emoji: nil, index: nil, slug: nil, title: nil, url: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Shortener.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Shortener.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{attention: true, clicks: 42, emoji: "some emoji", index: 42, slug: "some slug", title: "some title", url: "some url"}

      assert {:ok, %Link{} = link} = Shortener.create_link(valid_attrs)
      assert link.attention == true
      assert link.clicks == 42
      assert link.emoji == "some emoji"
      assert link.index == 42
      assert link.slug == "some slug"
      assert link.title == "some title"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{attention: false, clicks: 43, emoji: "some updated emoji", index: 43, slug: "some updated slug", title: "some updated title", url: "some updated url"}

      assert {:ok, %Link{} = link} = Shortener.update_link(link, update_attrs)
      assert link.attention == false
      assert link.clicks == 43
      assert link.emoji == "some updated emoji"
      assert link.index == 43
      assert link.slug == "some updated slug"
      assert link.title == "some updated title"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortener.update_link(link, @invalid_attrs)
      assert link == Shortener.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Shortener.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Shortener.change_link(link)
    end
  end

  describe "forms" do
    alias Linker.Shortener.Form

    import Linker.ShortenerFixtures

    @invalid_attrs %{name: nil, slug: nil, url: nil, visits: nil}

    test "list_forms/0 returns all forms" do
      form = form_fixture()
      assert Shortener.list_forms() == [form]
    end

    test "get_form!/1 returns the form with given id" do
      form = form_fixture()
      assert Shortener.get_form!(form.id) == form
    end

    test "create_form/1 with valid data creates a form" do
      valid_attrs = %{name: "some name", slug: "some slug", url: "some url", visits: 42}

      assert {:ok, %Form{} = form} = Shortener.create_form(valid_attrs)
      assert form.name == "some name"
      assert form.slug == "some slug"
      assert form.url == "some url"
      assert form.visits == 42
    end

    test "create_form/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_form(@invalid_attrs)
    end

    test "update_form/2 with valid data updates the form" do
      form = form_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug", url: "some updated url", visits: 43}

      assert {:ok, %Form{} = form} = Shortener.update_form(form, update_attrs)
      assert form.name == "some updated name"
      assert form.slug == "some updated slug"
      assert form.url == "some updated url"
      assert form.visits == 43
    end

    test "update_form/2 with invalid data returns error changeset" do
      form = form_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortener.update_form(form, @invalid_attrs)
      assert form == Shortener.get_form!(form.id)
    end

    test "delete_form/1 deletes the form" do
      form = form_fixture()
      assert {:ok, %Form{}} = Shortener.delete_form(form)
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_form!(form.id) end
    end

    test "change_form/1 returns a form changeset" do
      form = form_fixture()
      assert %Ecto.Changeset{} = Shortener.change_form(form)
    end
  end

  describe "redirects" do
    alias Linker.Shortener.Redirect

    import Linker.ShortenerFixtures

    @invalid_attrs %{link: nil, name: nil, slug: nil, url: nil, visits: nil}

    test "list_redirects/0 returns all redirects" do
      redirect = redirect_fixture()
      assert Shortener.list_redirects() == [redirect]
    end

    test "get_redirect!/1 returns the redirect with given id" do
      redirect = redirect_fixture()
      assert Shortener.get_redirect!(redirect.id) == redirect
    end

    test "create_redirect/1 with valid data creates a redirect" do
      valid_attrs = %{link: "some link", name: "some name", slug: "some slug", url: "some url", visits: 42}

      assert {:ok, %Redirect{} = redirect} = Shortener.create_redirect(valid_attrs)
      assert redirect.link == "some link"
      assert redirect.name == "some name"
      assert redirect.slug == "some slug"
      assert redirect.url == "some url"
      assert redirect.visits == 42
    end

    test "create_redirect/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_redirect(@invalid_attrs)
    end

    test "update_redirect/2 with valid data updates the redirect" do
      redirect = redirect_fixture()
      update_attrs = %{link: "some updated link", name: "some updated name", slug: "some updated slug", url: "some updated url", visits: 43}

      assert {:ok, %Redirect{} = redirect} = Shortener.update_redirect(redirect, update_attrs)
      assert redirect.link == "some updated link"
      assert redirect.name == "some updated name"
      assert redirect.slug == "some updated slug"
      assert redirect.url == "some updated url"
      assert redirect.visits == 43
    end

    test "update_redirect/2 with invalid data returns error changeset" do
      redirect = redirect_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortener.update_redirect(redirect, @invalid_attrs)
      assert redirect == Shortener.get_redirect!(redirect.id)
    end

    test "delete_redirect/1 deletes the redirect" do
      redirect = redirect_fixture()
      assert {:ok, %Redirect{}} = Shortener.delete_redirect(redirect)
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_redirect!(redirect.id) end
    end

    test "change_redirect/1 returns a redirect changeset" do
      redirect = redirect_fixture()
      assert %Ecto.Changeset{} = Shortener.change_redirect(redirect)
    end
  end
end
