defmodule Me.PersonModel do
  alias Me.{Repo, Email, Person}

  def get(person = %Person{}) do
    Me.Repo.get(Person, person.id)
    |> Repo.preload(:email)
    |> Repo.preload(:password)
    |> Repo.preload(:role)
  end

  def get_by_email(email) when is_binary(email) do
    email = Repo.get_by(Email, email: email)

    get(%Person{id: email.person_id})
  end
end
