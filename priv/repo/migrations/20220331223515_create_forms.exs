defmodule Linker.Repo.Migrations.CreateForms do
  use Ecto.Migration

  def change do
    create table(:forms) do
      add :name, :string
      add :slug, :string
      add :url, :text
      add :visits, :integer

      timestamps()
    end
  end
end
