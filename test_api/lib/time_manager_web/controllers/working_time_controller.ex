defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.Workingtimes
  alias TimeManager.Workingtimes.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"userID" => user_id}) do
    working_times = Workingtimes.list_user_working_times(user_id)
    render(conn, :index, working_times: working_times)
  end

  def show(conn, %{"userID" => user_id, "id" => id}) do
    working_time = Workingtimes.get_user_working_time!(user_id, id)
    render(conn, :show, working_time: working_time)
  end

  def create(conn, %{"userID" => user_id, "working_time" => working_time_params}) do
    params = Map.put(working_time_params, "user_id", user_id)

    with {:ok, %WorkingTime{} = working_time} <- Workingtimes.create_working_time(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtime/#{user_id}/#{working_time.id}")
      |> render(:show, working_time: working_time)
    end
  end

  def update(conn, %{"userID" => user_id, "id" => id, "working_time" => working_time_params}) do
    working_time = Workingtimes.get_user_working_time!(user_id, id)

    with {:ok, %WorkingTime{} = working_time} <-
           Workingtimes.update_working_time(working_time, working_time_params) do
      render(conn, :show, working_time: working_time)
    end
  end

  def delete(conn, %{"userID" => user_id, "id" => id}) do
    working_time = Workingtimes.get_user_working_time!(user_id, id)

    with {:ok, %WorkingTime{}} <- Workingtimes.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
