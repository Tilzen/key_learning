defmodule KeyLearning.Repo do
  use Ecto.Repo,
    otp_app: :key_learning,
    adapter: Ecto.Adapters.Postgres
end
