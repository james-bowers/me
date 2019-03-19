defmodule Me.Repo.Migrations.Person do
  use Ecto.Migration

  def change do
    create table("person") do
      add(:first_name, :string)
      add(:last_name, :string)
      add(:dob, :utc_datetime)

      timestamps()
    end
  end
end
