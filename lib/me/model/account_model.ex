defmodule Me.AccountModel do
  alias Ecto.Multi
  alias Me.{Account}

  def insert() do
    Multi.new()
    |> Multi.insert(:account, insert_changeset())
  end

  def insert_changeset do
    %Account{}
    |> Account.changeset(%{})
  end
end
