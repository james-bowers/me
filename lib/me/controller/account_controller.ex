defmodule Me.AccountController do
  alias Ecto.Multi
  alias Me.{Repo, AccountModel}

  def insert() do
    Multi.new()
    |> AccountModel.insert()
    |> Repo.transaction()
  end
end
