defmodule Linker.MixProject do
  use Mix.Project

  @app :linker
  @name "JOIN Linker"
  @version "1.0.0-beta"
  @description "A Job Shop aimed at students in the field of computing"

  def project do
    [
      app: @app,
      name: @name,
      version: @version,
      description: @description,
      git_ref: git_revision_hash(Mix.env()),
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [check: :test]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Linker.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # web
      {:phoenix, "~> 1.6.10"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_view, "~> 0.17.10"},

      # database
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},

      # security
      {:bcrypt_elixir, "~> 3.0"},

      # mailer
      {:swoosh, "~> 1.5"},

      # i18n
      {:gettext, "~> 0.18"},

      # monitoring
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:phoenix_live_dashboard, "~> 0.6"},

      # utilities
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},

      # testing
      {:floki, ">= 0.30.0", only: :test},

      # development
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:esbuild, "~> 0.5", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},

      # tools
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "ecto.seed"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      check: [
        "clean",
        "deps.unlock --check-unused",
        "compile --all-warnings --warnings-as-errors",
        "format --check-formatted",
        "deps.unlock --check-unused",
        "test --warnings-as-errors",
        "credo --strict --all"
      ],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end

  defp git_revision_hash(:prod), do: System.get_env("SOURCE_VERSION")

  defp git_revision_hash(_env) do
    case System.cmd("git", ["rev-parse", "HEAD"]) do
      {ref, 0} ->
        ref

      {_, _code} ->
        ["ref:", ref_path] =
          File.read!(".git/HEAD")
          |> String.split()

        File.read!(".git/#{ref_path}")
    end
    |> String.replace("\n", "")
  end
end
