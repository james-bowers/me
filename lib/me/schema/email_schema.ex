defmodule Me.Email do
  use Me.BaseSchema
  import Ecto.Changeset

  alias Me.{Person}

  schema "email" do
    field(:email, :string)
    field(:verified, :integer, default: 0)
    belongs_to(:person, Person)

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :verified])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
