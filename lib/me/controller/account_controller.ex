defmodule Me.AccountController do
  alias Me.{Repo, AccountModel}

  def insert() do
    AccountModel.insert()
    |> Repo.transaction()
  end
end
