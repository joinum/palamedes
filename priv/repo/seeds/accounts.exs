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
            password: "GZqi588cWAK4Ti123SAQWE1312RRQW112!?",
            admin: true
          },
          %{
            email: "join.uminho.di@gmail.com",
            password: "FAQWE596123RGPK4in12213!!asdADDA1209!",
            admin: true
          },
          %{
            email: "felicio@gmail.com",
            password: "Password1234567890",
            admin: false
          },
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
