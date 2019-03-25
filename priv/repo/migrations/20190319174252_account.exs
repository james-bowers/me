defmodule Me.Repo.Migrations.Account do
  use Ecto.Migration

  def change do
    create table("account") do
      add(:active, :integer, default: 1)

      timestamps()
    end
  end
end
