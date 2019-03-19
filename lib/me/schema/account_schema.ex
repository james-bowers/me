defmodule Me.Account do
  use Me.BaseSchema
  import Ecto.Changeset

  schema "account" do
    field(:active, :integer, default: 1)

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:active])
  end
end
