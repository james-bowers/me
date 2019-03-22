defmodule Me.Person do
  use Me.BaseSchema
  import Ecto.Changeset

  alias Me.{Account, Person, Role, Password, Email}

  schema "person" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:dob, :utc_datetime)
    has_one(:password, Password)
    has_many(:email, Email)
    has_many(:role, Role)

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:first_name, :last_name])
  end
end
