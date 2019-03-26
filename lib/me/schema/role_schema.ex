defmodule Me.Role do
  use Me.BaseSchema
  import Ecto.Changeset

  alias Me.{Account, Person}

  schema "role" do
    field(:permission_level, :integer, default: 0)
    belongs_to(:account, Account)
    belongs_to(:person, Person)

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:account_id, :person_id, :permission_level])
  end
end
