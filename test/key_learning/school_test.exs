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
end
