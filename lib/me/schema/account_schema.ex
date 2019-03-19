defmodule Me.Account do
  use Me.BaseSchema
  import Ecto.Changeset

  schema "account" do
    field :first_name, :string
    field :last_name, :string
    field :active, :integer
    field :dob, :utc_datetime
    
    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:first_name, :last_name, :active, :dob])
  end
end