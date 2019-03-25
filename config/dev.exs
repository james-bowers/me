use Mix.Config

config :logger, level: :info

config :me, Me.Repo,
  database: "me_repo",
  username: "postgres",
  password: "pass",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox
