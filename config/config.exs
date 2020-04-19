# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :testpow,
  ecto_repos: [Testpow.Repo]

# Configures the endpoint
config :testpow, TestpowWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wZUNsSUJHDSEjzzQV5+gkfgJCkdtmCW2P3Yr9CzO8bnVQxzkpinf7twNQg3APiNP",
  render_errors: [view: TestpowWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Testpow.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "GrXe9pBm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

#  Configure Pow
config :testpow, :pow,
  user: Testpow.Users.User,
  repo: Testpow.Repo,
  extensions: [PowInvitation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: TestpowWeb.PowMailer,
  web_module: TestpowWeb

# Configure Triplex
config :triplex, repo: Testpow.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
