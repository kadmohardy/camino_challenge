use Mix.Config

config :camino_challenge, CaminoChallengeWeb.Endpoint,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :camino_challenge,
  uploads_directory: System.get_env("CAMINO_CHALLENGE_UPLOADS_DIRECTORY") || "/uploads"

# Do not print debug messages in production
config :logger, level: :info
