defmodule TimeManager.Workingtimes do
  @moduledoc """
  The Workingtimes context.
  """

  import Ecto.Query, only: [where: 3]
  alias TimeManager.Repo
  alias TimeManager.Workingtimes.WorkingTime

  def list_user_working_times(user_id) do
    WorkingTime
    |> where([w], w.user_id == ^user_id)
    |> Repo.all()
  end

  def get_working_time!(id), do: Repo.get!(WorkingTime, id)

  def get_user_working_time!(user_id, id) do
    WorkingTime
    |> where([w], w.id == ^id and w.user_id == ^user_id)
    |> Repo.one!()
  end

  def create_working_time(attrs \\ %{}) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()
  end

  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end
end
