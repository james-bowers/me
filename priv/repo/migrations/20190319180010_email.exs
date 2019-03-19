defmodule Me.Repo.Migrations.Email do
  use Ecto.Migration

  def change do
    create table("email") do
      add(:person_id, references(:person))
      add(:email, :string)
      add(:verified, :integer)

      timestamps()
    end
  end
end
