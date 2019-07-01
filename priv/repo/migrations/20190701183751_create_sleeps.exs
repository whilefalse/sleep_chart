defmodule SleepChart.Repo.Migrations.CreateSleeps do
  use Ecto.Migration

  def change do
    create table(:sleeps) do
      add :date, :date, null: false
      add :slept, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:sleeps, [:date])
  end
end
