defmodule ChatApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :chat_api,
      version: "1.0.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],

      # Docs
      name: "ChatApi",
      source_url: "https://github.com/vbrazo/chat_api",
      homepage_url: "https://github.com/vbrazo/chat_api",
      # The main page in the docs
      docs: [main: "README", extras: ["README.md"]]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {ChatApi.Application, []}, extra_applications: [:logger, :runtime_tools, :comeonin]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/factories"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, "~> 0.13.3"},
      {:gettext, "~> 0.11"},
      {:proper_case, "~> 1.0.0"},
      {:cowboy, "~> 1.1"},
      {:plug_cowboy, "~> 1.0.0"},
      {:comeonin, "~> 3.2"},
      {:guardian, "~> 1.0"},
      {:excoveralls, "~> 0.7", only: [:dev, :test]},
      {:credo, "~> 0.8.5", only: [:dev, :test]},
      {:ex_machina, "~> 2.0", only: :test},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:faker, "~> 0.16", only: :test},
      {:plug, "~> 1.0"},
      {:corsica, "~> 1.0"},
      {:redix, ">= 0.0.0"},
      {:castore, ">= 0.0.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "db.setup": ["ecto.create", "ecto.load", "run priv/repo/seeds.exs"],
      "db.reset": ["ecto.drop", "db.setup"],
      "db.migrate": ["ecto.migrate", "ecto.dump"],
      "db.pristine": [
        "ecto.drop",
        "ecto.create",
        "ecto.load --dump-path priv/repo/base.sql",
        "ecto.migrate",
        "run priv/repo/seeds.exs"
      ],
      test: ["ecto.create", "ecto.load --skip-if-loaded", "test"]
    ]
  end

  # mutes compiler warnings
  Code.compiler_options(ignore_module_conflict: true)
end
