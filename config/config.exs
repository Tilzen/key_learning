# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :key_learning,
  ecto_repos: [KeyLearning.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :key_learning, KeyLearningWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ao37U3PMnKDSXfWLLPrWfsHJkqwtvm+BufJYRwsv5wLxVez6fIkm9qmRZp672nlt",
  render_errors: [view: KeyLearningWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: KeyLearning.PubSub,
  live_view: [signing_salt: "7jChJonT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :key_learning, KeyLearning.Guardian,
  issuer: "key_learning",
  secret_key: "pETVK5w4PUpFfGshGJpkCeV2wCm+CFQKm25WTFkjU0lMLc4p+V+yOvCDJhLh0o3y"

config :key_learning, KeyLearningWeb.Plugs.AuthAccessPipelinePlug,
  module: KeyLearning.Guardian,
  error_handler: KeyLearningWeb.Plugs.AuthErrorHandlerPlug

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
