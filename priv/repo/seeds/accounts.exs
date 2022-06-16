defmodule Linker.Repo.Seeds.Accounts do
  require Logger

  alias Linker.Repo

  alias Linker.Accounts.User

  def run do
    seed_accounts()
  end

  def seed_accounts do
    case Repo.all(User) do
      [] ->
        [
          %{
            email: "cesium@di.uminho.pt",
            password: "Password1234!",
            admin: true
          },
          %{
            email: "necc@di.uminho.pt",
            password: "Password1234!",
            admin: true
          }
        ]
        |> Enum.each(&insert_user/1)

      _ ->
        Mix.shell().error("Found users, aborting seeding users.")
    end
  end

  defp insert_user(data) do
    %User{}
    |> User.registration_changeset(data)
    |> Repo.insert!()
  end

end

Linker.Repo.Seeds.Accounts.run()
