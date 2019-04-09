defmodule Me.RoleModel do
  alias Me.{Role, Repo, Account, Person}
  alias Ecto.Multi
  import Ecto.Query

  def list(%Person{id: person_id}) do
    from(r in Role,
      where: r.person_id == ^person_id,
      order_by: r.inserted_at
    )
    |> Repo.all()
  end

  def get(role = %Role{}) do
    Repo.get(Role, role.id)
    |> Repo.preload([:person, :account])
    |> Repo.preload([{:person, :email}, :person])
  end

  def insert(%{
        permission_level: permission_level,
        account: account = %Account{},
        person: person = %Person{}
      }) do
    Multi.new()
    |> Multi.insert(
      :role,
      insert_changeset(%{
        person_id: person.id,
        account_id: account.id,
        permission_level: permission_level
      })
    )
  end

  def insert_changeset(attrs) do
    %Role{}
    |> Role.changeset(attrs)
  end
end
