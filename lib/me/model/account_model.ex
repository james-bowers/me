defmodule Me.AccountModel do
  alias Ecto.Multi
  alias Me.{Repo, Account, Guardian}

  def get(account = %Account{}) do
    Repo.get(Account, account.id)
  end

  def insert() do
    Multi.new()
    |> Multi.insert(:account, insert_changeset())
  end

  def insert_changeset do
    %Account{}
    |> Account.changeset(%{})
  end
end
