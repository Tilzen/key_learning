defmodule KeyLearningWeb.Api.LectureController do
  use KeyLearningWeb, :controller

  alias KeyLearning.School
  alias KeyLearning.School.Lecture

  action_fallback KeyLearningWeb.FallbackController

  def index(conn, _params) do
    lectures = School.list_lectures()
    render(conn, "index.json", lectures: lectures)
  end

  def create(conn, %{"lecture" => lecture_params}) do
    with {:ok, %Lecture{} = lecture} <- School.create_lecture(lecture_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_lecture_path(conn, :show, lecture))
      |> render("show.json", lecture: lecture)
    end
  end

  def show(conn, %{"id" => id}) do
    lecture = School.get_lecture!(id)
    render(conn, "show.json", lecture: lecture)
  end

  def update(conn, %{"id" => id, "lecture" => lecture_params}) do
    lecture = School.get_lecture!(id)

    with {:ok, %Lecture{} = lecture} <- School.update_lecture(lecture, lecture_params) do
      render(conn, "show.json", lecture: lecture)
    end
  end

  def delete(conn, %{"id" => id}) do
    lecture = School.get_lecture!(id)

    with {:ok, %Lecture{}} <- School.delete_lecture(lecture) do
      send_resp(conn, :no_content, "")
    end
  end
end
