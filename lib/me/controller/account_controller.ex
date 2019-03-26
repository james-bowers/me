defmodule Me.AccountController do
  alias Me.{Repo, Role, AccountModel, RoleController}

  def insert() do
    AccountModel.insert()
    |> Repo.transaction()
    |> add_anonymous_user_token()
  end

  defp add_anonymous_user_token({:ok, changes = %{account: account}}) do
    {:ok, token, _claims} =
      RoleController.sign(%Role{account_id: account.id, permission_level: 0})

    {:ok,
     changes
     |> Map.put(:token, token)}
  end
end
