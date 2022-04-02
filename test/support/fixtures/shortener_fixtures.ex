defmodule Linker.ShortenerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Linker.Shortener` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        attention: true,
        clicks: 42,
        emoji: "some emoji",
        index: 42,
        slug: "some slug",
        title: "some title",
        url: "some url"
      })
      |> Linker.Shortener.create_link()

    link
  end

  @doc """
  Generate a form.
  """
  def form_fixture(attrs \\ %{}) do
    {:ok, form} =
      attrs
      |> Enum.into(%{
        name: "some name",
        slug: "some slug",
        url: "some url",
        visits: 42
      })
      |> Linker.Shortener.create_form()

    form
  end
end
