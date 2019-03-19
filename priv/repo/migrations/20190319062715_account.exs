defmodule Me.Repo.Migrations.Account do
  use Ecto.Migration

  def change do
    create table("account") do
      add(:first_name, :string)
      add(:last_name, :string)
      add(:active, :integer)
      add(:dob, :utc_datetime)

      timestamps()
    end
  end
end
