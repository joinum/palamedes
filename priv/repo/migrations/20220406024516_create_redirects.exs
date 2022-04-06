defmodule Linker.Repo.Migrations.CreateRedirects do
  use Ecto.Migration

  def change do
    create table(:redirects) do
      add :name, :string
      add :slug, :string
      add :url, :string
      add :link, :string
      add :visits, :integer

      timestamps()
    end
  end
end
