use Mix.Config

config :logger, level: :warn

config :me, Me.Repo,
  database: "me_repo",
  username: "postgres",
  password: "pass",
  # change hostname to db, when github actions supports `docker-compose run test`
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
