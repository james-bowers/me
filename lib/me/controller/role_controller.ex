defmodule Me.RoleController do
  alias Me.{Repo, Role, Account, Person, Guardian, RoleModel}

  def sign(role = %Role{}) do
    Me.Guardian.encode_and_sign(role)
  end

  def validate(token) do
    Guardian.decode_and_verify(token)
  end

  def fetch_resource(%{"sub" => role_id}) do
    RoleModel.get(%Role{id: role_id})
  end

  def link(%{person_id: person_id, account_id: account_id, permission_level: permission_level})
      when is_integer(permission_level) do
    RoleModel.insert(%{
      account: %Account{id: account_id},
      person: %Person{id: person_id},
      permission_level: permission_level
    })
    |> Repo.transaction()
    |> add_token_after_link()
  end

  def add_token_after_link({:ok, %{role: role = %Role{}}}) do
    {:ok, token, _claims} = sign(role)
    {:ok, %{role: role, token: token}}
  end

  def add_token_after_link({:error, :role, changeset, _changes}) do
    {:error, changeset}
  end
end
