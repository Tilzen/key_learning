defmodule KeyLearning.SchoolTest do
  use KeyLearning.DataCase

  alias KeyLearning.School

  describe "courses" do
    alias KeyLearning.School.Course

    @valid_attrs %{image_path: "some image_path", name: "some name"}
    @update_attrs %{image_path: "some updated image_path", name: "some updated name"}
    @invalid_attrs %{image_path: nil, name: nil}

    def course_fixture(attrs \\ %{}) do
      {:ok, course} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_course()

      course
    end

    test "list_courses/0 returns all courses" do
      course = course_fixture()
      assert School.list_courses() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = course_fixture()
      assert School.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      assert {:ok, %Course{} = course} = School.create_course(@valid_attrs)
      assert course.image_path == "some image_path"
      assert course.name == "some name"
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = course_fixture()
      assert {:ok, %Course{} = course} = School.update_course(course, @update_attrs)
      assert course.image_path == "some updated image_path"
      assert course.name == "some updated name"
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = course_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_course(course, @invalid_attrs)
      assert course == School.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = course_fixture()
      assert {:ok, %Course{}} = School.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> School.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = course_fixture()
      assert %Ecto.Changeset{} = School.change_course(course)
    end
  end

  describe "lectures" do
    alias KeyLearning.School.Lecture

    @valid_attrs %{description: "some description", duration: 42, name: "some name", video_url: "some video_url"}
    @update_attrs %{description: "some updated description", duration: 43, name: "some updated name", video_url: "some updated video_url"}
    @invalid_attrs %{description: nil, duration: nil, name: nil, video_url: nil}

    def lecture_fixture(attrs \\ %{}) do
      course = course_fixture()
      {:ok, lecture} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.put(:course_id, course.id)
        |> School.create_lecture()

      lecture
    end

    test "list_lectures/0 returns all lectures" do
      lecture = lecture_fixture()
      assert School.list_lectures() == [lecture]
    end

    test "get_lecture!/1 returns the lecture with given id" do
      lecture = lecture_fixture()
      assert School.get_lecture!(lecture.id) == lecture
    end

    test "create_lecture/1 with valid data creates a lecture" do
      course = course_fixture()
      valid_attrs = @valid_attrs |> Map.put(:course_id, course.id)
      assert {:ok, %Lecture{} = lecture} = School.create_lecture(valid_attrs)
      assert lecture.description == "some description"
      assert lecture.duration == 42
      assert lecture.name == "some name"
      assert lecture.video_url == "some video_url"
    end

    test "create_lecture/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_lecture(@invalid_attrs)
    end

    test "update_lecture/2 with valid data updates the lecture" do
      lecture = lecture_fixture()
      assert {:ok, %Lecture{} = lecture} = School.update_lecture(lecture, @update_attrs)
      assert lecture.description == "some updated description"
      assert lecture.duration == 43
      assert lecture.name == "some updated name"
      assert lecture.video_url == "some updated video_url"
    end

    test "update_lecture/2 with invalid data returns error changeset" do
      lecture = lecture_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_lecture(lecture, @invalid_attrs)
      assert lecture == School.get_lecture!(lecture.id)
    end

    test "delete_lecture/1 deletes the lecture" do
      lecture = lecture_fixture()
      assert {:ok, %Lecture{}} = School.delete_lecture(lecture)
      assert_raise Ecto.NoResultsError, fn -> School.get_lecture!(lecture.id) end
    end

    test "change_lecture/1 returns a lecture changeset" do
      lecture = lecture_fixture()
      assert %Ecto.Changeset{} = School.change_lecture(lecture)
    end
  end
end
