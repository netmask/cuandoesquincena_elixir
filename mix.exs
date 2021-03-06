defmodule Cuandoesquincena.Mixfile do
  use Mix.Project

  def project do
    [app: :cuandoesquincena,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: Cuandoesquincena],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger, :tzdata, :cowboy, :timex, :plug, :poison],
      env: env,
      mod: {Cuandoesquincena, []}
    ]
  end

  defp env do
    [autoupdate: :enabled, data_dir: nil]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:tzdata, "~> 0.5.7", override: true},
      {:timex, "~> 2.1.4"},
      {:plug, "~> 1.0"},
      {:poison, "~> 2.0"},
      {:exrm, "~> 1.0.0"},
      {:exrm_docker, "~> 0.0.4"}
    ]
  end
end
