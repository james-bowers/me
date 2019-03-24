defmodule Me.PersonModel do
  alias Me.{Repo, Email, Person, EmailModel, PasswordModel}
  alias Ecto.Multi

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

  def insert(multi \\ Multi.new(), %{email: email, password: password}) do
    multi
    |> Multi.insert(:person, Person.changeset(%Person{}, %{}))
    |> Multi.merge(fn %{person: person} ->
      EmailModel.insert(%{email: email, person_id: person.id})
    end)
    |> Multi.merge(fn %{person: person} ->
      PasswordModel.insert(%{password: password, person_id: person.id})
    end)
  end
end
