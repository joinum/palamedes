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
end
