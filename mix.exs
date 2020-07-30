defmodule Thermox.MixProject do
  use Mix.Project

  def project do
    [
      app: :thermox,
      version: get_version("1.0.0"),
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Thermox.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.10"},
      {:cowboy, "~> 2.7"},
      {:jason, "~> 1.2"},
      {:elixir_ale, "~> 1.2"},
      {:plug_cowboy, "~> 2.2"},
      {:ecto_sql, "~> 3.4"},
      {:remix, "~> 0.0.2", only: :dev},
      {:postgrex, "~> 0.15"}
    ]
  end

  defp get_version(v), do: "#{v}-#{get_sha()}"

  defp get_sha() do
    case System.get_env("SOURCE_VERSION") do
      "" -> "dev"
      nil -> "dev"
      version -> version
    end
  end
end
