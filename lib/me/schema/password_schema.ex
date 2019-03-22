defmodule Me.Password do
  use Me.BaseSchema
  import Ecto.Changeset

  alias Me.{Person}

  schema "password" do
    field(:password_hash, :string)
    belongs_to(:person, Person)

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:password_hash])
  end
end
