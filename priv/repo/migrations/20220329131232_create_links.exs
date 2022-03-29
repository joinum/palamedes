defmodule Linker.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :title, :string
      add :url, :text
      add :emoji, :string
      add :attention, :boolean, default: false, null: false
      add :index, :integer
      add :slug, :string
      add :clicks, :integer

      timestamps()
    end
  end
end
