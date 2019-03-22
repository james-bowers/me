defmodule Me.Repo.Migrations.Password do
  use Ecto.Migration

  def change do
    create table("password") do
      add(:person_id, references(:person))
      add(:password_hash, :string)

      timestamps()
    end
  end
end
