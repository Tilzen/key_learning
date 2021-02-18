defmodule KeyLearning.School.Lecture do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "lectures" do
    field :description, :string
    field :duration, :integer
    field :name, :string
    field :video_url, :string
    belongs_to :course, KeyLearning.School.Course

    timestamps()
  end

  @doc false
  def changeset(lecture, attrs) do
    fields = [:name, :duration, :description, :video_url, :course_id]

    lecture
    |> cast(attrs, fields)
    |> validate_required(fields)
  end
end
