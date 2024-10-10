defmodule TimeManager.Repo.Migrations.FixWorkingTimesUserRelation do
  use Ecto.Migration

  def change do
    # Drop the existing index
    drop index(:working_times, [:user])

    # Modify the user column to user_id
    alter table(:working_times) do
      remove :user
      add :user_id, references(:users, on_delete: :delete_all), null: false
    end

    # Create new index
    create index(:working_times, [:user_id])
  end
end
