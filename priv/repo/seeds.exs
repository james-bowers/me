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
account2_id = "d75a9cd2-acec-46be-81e7-84a786971d44"
account3_id = "6fb779ee-8215-4873-8275-285dccc12f9f"

role1_id = "f8c8a516-ad0a-4409-aca1-40c74b48d81a"

person1_id = "c6d771c9-debe-4276-bd32-d2ca2b2c394f"

email1_id = "6229f4d1-ee8b-482f-974c-7ed6ed2782c6"

# Account
Me.Repo.insert!(%Me.Account{id: account1_id})
Me.Repo.insert!(%Me.Account{id: account2_id})
Me.Repo.insert!(%Me.Account{id: account3_id})

# Person
{:ok, datetime, 0} = DateTime.from_iso8601("1996-07-09T00:00:00Z")
Me.Repo.insert!(%Me.Person{
  id: person1_id,
  first_name: "James",
  last_name: "Bowers",
  dob: datetime,
  inserted_at: ~N[2019-03-20 19:26:39],
  updated_at: ~N[2019-03-20 19:26:39]
})

# Role
Me.Repo.insert!(%Me.Role{
  id: role1_id, 
  account_id: account2_id,
  person_id: person1_id,
  permission_level: 0,
  inserted_at: ~N[2019-03-20 19:26:39],
  updated_at: ~N[2019-03-20 19:26:39]
})

# Email
Me.Repo.insert!(%Me.Email{
  id: email1_id,
  person_id: person1_id,
  email: "james@ticketbuddy.co.uk",
  verified: 0,
  inserted_at: ~N[2019-03-20 19:26:39],
  updated_at: ~N[2019-03-20 19:26:39]
})

# Password
Me.Repo.insert!(%Me.Password{
  person_id: person1_id,
  password_hash: "$2b$12$w/ygPaYlXRhzubnAj/7.xueZQpqbGmbTQ4OrzHaaY90Rma7MBkKVG",
  inserted_at: ~N[2019-03-20 19:26:39],
  updated_at: ~N[2019-03-20 19:26:39]
})