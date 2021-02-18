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
    field :course_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(lecture, attrs) do
    lecture
    |> cast(attrs, [:name, :duration, :description, :video_url])
    |> validate_required([:name, :duration, :description, :video_url])
  end
end
