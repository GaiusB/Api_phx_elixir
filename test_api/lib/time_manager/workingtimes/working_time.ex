# lib/time_manager/workingtimes/working_time.ex
defmodule TimeManager.Workingtimes.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "working_times" do
    field :start, :naive_datetime
    field :end, :naive_datetime
    belongs_to :user, TimeManager.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end, :user_id])
    |> foreign_key_constraint(:user_id)
    |> validate_start_before_end()
  end

  # Validates that the start time is before the end time
  defp validate_start_before_end(changeset) do
    case {get_field(changeset, :start), get_field(changeset, :end)} do
      {start, end_time} when not is_nil(start) and not is_nil(end_time) ->
        if NaiveDateTime.compare(start, end_time) == :lt do
          changeset
        else
          add_error(changeset, :start, "must be before end time")
        end

      _ ->
        changeset
    end
  end
end
