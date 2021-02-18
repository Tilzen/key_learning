defmodule KeyLearningWeb.Api.CourseView do
  use KeyLearningWeb, :view
  alias KeyLearningWeb.Api.CourseView

  def render("index.json", %{courses: courses}) do
    %{data: render_many(courses, CourseView, "course.json")}
  end

  def render("show.json", %{course: course}) do
    %{data: render_one(course, CourseView, "course.json")}
  end

  def render("course.json", %{course: course}) do
    %{id: course.id, name: course.name, image_path: course.image_path}
  end
end
