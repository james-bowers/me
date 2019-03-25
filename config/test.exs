use Mix.Config

config :logger, level: :warn

config :me, Me.Repo,
  database: "me_repo",
  username: "postgres",
  password: "pass",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
