defmodule SleepChart.Repo.Migrations.CreateSleeps do
  use Ecto.Migration

  def change do
    create table(:sleeps) do
      add :date, :date
      add :slept, :boolean, default: false, null: false

      timestamps()
    end

  end
end
