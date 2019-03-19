defmodule Me.Repo.Migrations.Role do
  use Ecto.Migration

  def change do
    create table("role") do      
      add(:account_id, references(:account))
      add(:person_id, references(:person))
      add(:permission_level, :integer)

      timestamps()
    end
  end
end
