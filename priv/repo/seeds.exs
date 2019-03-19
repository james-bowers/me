# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Me.Repo.insert!(%Me.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

IO.puts("Setting up seed data...")

account1_id = "7119e5c9-37b5-4fb2-bf42-7981f4ec8d6a"

Me.Repo.insert!(%Me.Account{id: account1_id})