defmodule KeyLearningWeb.Api.LectureView do
  use KeyLearningWeb, :view
  alias KeyLearningWeb.Api.LectureView

  def render("index.json", %{lectures: lectures}) do
    %{data: render_many(lectures, LectureView, "lecture.json")}
  end

  def render("show.json", %{lecture: lecture}) do
    %{data: render_one(lecture, LectureView, "lecture.json")}
  end

  def render("lecture.json", %{lecture: lecture}) do
    %{
      id: lecture.id,
      name: lecture.name,
      duration: lecture.duration,
      description: lecture.description,
      video_url: lecture.video_url
    }
  end
end
