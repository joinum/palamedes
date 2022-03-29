defmodule Linker.Shortener.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :attention, :boolean, default: false
    field :clicks, :integer
    field :emoji, :string
    field :index, :integer
    field :slug, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:title, :url, :emoji, :attention, :index, :slug, :clicks])
    |> validate_required([:title, :url, :emoji, :attention, :index, :slug, :clicks])
  end
end
