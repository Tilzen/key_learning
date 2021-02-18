defmodule KeyLearningWeb.Api.LectureControllerTest do
  use KeyLearningWeb.ConnCase

  alias KeyLearning.School
  alias KeyLearning.School.Lecture

  @create_attrs %{
    description: "some description",
    duration: 42,
    name: "some name",
    video_url: "some video_url"
  }
  @update_attrs %{
    description: "some updated description",
    duration: 43,
    name: "some updated name",
    video_url: "some updated video_url"
  }
  @invalid_attrs %{description: nil, duration: nil, name: nil, video_url: nil}

  def fixture(:lecture) do
    {:ok, course} = KeyLearning.School.create_course(
      %{name: "tests with elixir/phoenix", image_path: "any_path"}
    )

    create_attrs = @create_attrs |> Map.put(:course_id, course.id)
    {:ok, lecture} = School.create_lecture(create_attrs)
    lecture
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all lectures", %{conn: conn} do
      conn = get(conn, Routes.api_lecture_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create lecture" do
    setup :register_and_sign_in_for_jwt

    test "renders lecture when data is valid", %{conn: conn} do
      {:ok, course} = KeyLearning.School.create_course(
        %{name: "tests with elixir/phoenix", image_path: "any_path"}
      )

      create_attrs = @create_attrs |> Map.put(:course_id, course.id)
      conn = post(conn, Routes.api_lecture_path(conn, :create), lecture: create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_lecture_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "duration" => 42,
               "name" => "some name",
               "video_url" => "some video_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_lecture_path(conn, :create), lecture: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update lecture" do
    setup [:create_lecture, :register_and_sign_in_for_jwt]

    test "renders lecture when data is valid", %{conn: conn, lecture: %Lecture{id: id} = lecture} do
      conn = put(conn, Routes.api_lecture_path(conn, :update, lecture), lecture: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_lecture_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "duration" => 43,
               "name" => "some updated name",
               "video_url" => "some updated video_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, lecture: lecture} do
      conn = put(conn, Routes.api_lecture_path(conn, :update, lecture), lecture: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete lecture" do
    setup [:create_lecture, :register_and_sign_in_for_jwt]

    test "deletes chosen lecture", %{conn: conn, lecture: lecture} do
      conn = delete(conn, Routes.api_lecture_path(conn, :delete, lecture))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_lecture_path(conn, :show, lecture))
      end
    end
  end

  defp create_lecture(_) do
    lecture = fixture(:lecture)
    %{lecture: lecture}
  end
end
