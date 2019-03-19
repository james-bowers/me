defmodule Me.Repo.Migrations.Account do
  use Ecto.Migration

  def change do
    create table("account") do
      add(:active, :integer)

      timestamps()
    end
  end
end
