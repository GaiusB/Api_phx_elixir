defmodule TimeManager.WorkingtimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Workingtimes` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~N[2024-10-08 13:49:00],
        start: ~N[2024-10-08 13:49:00]
      })
      |> TimeManager.Workingtimes.create_working_time()

    working_time
  end
end
