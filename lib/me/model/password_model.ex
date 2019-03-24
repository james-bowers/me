defmodule Me.PasswordModel do
  alias Ecto.Multi
  alias Me.{Password}

  def insert(multi \\ Multi.new(), attrs = %{person_id: _person_id, password: _password}) do
    multi
    |> Multi.insert(:password, insert_changeset(attrs))
  end

  def insert_changeset(attrs) do
    %Password{}
    |> Password.changeset(attrs)
  end
end
