defmodule Me.Password do
  use Me.BaseSchema
  import Ecto.Changeset

  alias Me.{Person, Password}

  schema "password" do
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    belongs_to(:person, Person)

    timestamps()
  end

  def changeset(account, attrs) do
    %Password{}
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
