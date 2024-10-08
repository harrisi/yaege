defmodule Yaege.MixProject do
  use Mix.Project

  def project do
    [
      app: :yaege,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: extra_applications(Mix.env()),
      mod: {Yaege.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:wx_ex, "~> 0.5.0", runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp extra_applications(:dev) do
    [
      :wx,
      :observer,
      :tools,
      :runtime_tools
      | extra_applications(:_)
    ]
  end

  defp extra_applications(_), do: [:logger]
end
