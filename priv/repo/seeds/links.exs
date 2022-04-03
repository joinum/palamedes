defmodule Linker.Repo.Seeds.Link do

  alias Linker.Repo

  alias Linker.Shortener.Link

  def run do
    case Repo.all(Link) do
      [] ->
        [
          %{
            index: 1,
            title: "Website",
            emoji: "🌐",
            clicks: 0,
            slug: "website",
            url: "https://join.di.uminho.pt/",
            attention: false
          },
          %{
            index: 2,
            title: "Healthy Disagreement",
            emoji: "🐻",
            clicks: 0,
            slug: "jre",
            url: "https://www.youtube.com/watch?v=djD9fSSqXeA",
            attention: false
          },
          %{
            index: 3,
            title: "Dinheiro Gratis",
            emoji: "🤑",
            clicks: 0,
            slug: "$$$$$",
            url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            attention: false
          },
          %{
            index: 4,
            title: "Fado Portugues",
            emoji: "🎤",
            clicks: 0,
            slug: "amalia",
            url: "https://www.youtube.com/watch?v=fIn9ccVbBzI&t=1750s",
            attention: true
          }
        ]
        |> Enum.each(&Repo.insert!(Link.changeset(%Link{}, &1)))
      _ ->
        Mix.shell().error("Found links, aborting seeding links.")
    end
  end
end

Linker.Repo.Seeds.Link.run()
