defmodule KeyLearningWeb.Api.CourseController do
  use KeyLearningWeb, :controller

  alias KeyLearning.School
  alias KeyLearning.School.Course

  action_fallback KeyLearningWeb.FallbackController

  def index(conn, _params) do
    courses = School.list_courses()
    render(conn, "index.json", courses: courses)
  end

  def create(conn, %{"course" => course_params}) do
    with {:ok, %Course{} = course} <- School.create_course(course_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_course_path(conn, :show, course))
      |> render("show.json", course: course)
    end
  end

  def show(conn, %{"id" => id}) do
    course = School.get_course!(id)
    render(conn, "show.json", course: course)
  end

  def update(conn, %{"id" => id, "course" => course_params}) do
    course = School.get_course!(id)

    with {:ok, %Course{} = course} <- School.update_course(course, course_params) do
      render(conn, "show.json", course: course)
    end
  end

  def delete(conn, %{"id" => id}) do
    course = School.get_course!(id)

    with {:ok, %Course{}} <- School.delete_course(course) do
      send_resp(conn, :no_content, "")
    end
  end
end
