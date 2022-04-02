defmodule Linker.Shortener.Form do
  use Ecto.Schema
  import Ecto.Changeset

  schema "forms" do
    field :name, :string
    field :slug, :string
    field :url, :string
    field :visits, :integer

    timestamps()
  end

  @doc false
  def changeset(form, attrs) do
    form
    |> cast(attrs, [:name, :slug, :url, :visits])
    |> validate_required([:name, :slug, :url, :visits])
  end
end
