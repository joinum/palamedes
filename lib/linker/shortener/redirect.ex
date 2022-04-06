defmodule Linker.Shortener.Redirect do
  use Ecto.Schema
  import Ecto.Changeset

  schema "redirects" do
    field :link, :string
    field :name, :string
    field :slug, :string
    field :url, :string
    field :visits, :integer

    timestamps()
  end

  @doc false
  def changeset(redirect, attrs) do
    redirect
    |> cast(attrs, [:name, :slug, :url, :link, :visits])
    |> validate_required([:name, :slug, :url, :link, :visits])
  end
end
