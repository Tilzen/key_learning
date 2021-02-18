defmodule KeyLearning.Repo.Migrations.CreateLectures do
  use Ecto.Migration

  def change do
    create table(:lectures, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :duration, :integer
      add :description, :text
      add :video_url, :string
      add :course_id, references(:courses, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:lectures, [:course_id])
  end
end
