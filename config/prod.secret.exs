use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).

secret_key_base = System.get_env("CF_PHOENIX_SECRET_KEY_BASE") || raise "CF_PHOENIX_SECRET_KEY_BASE must be set"

config :cf_phoenix, CfPhoenix.Endpoint,
  secret_key_base: secret_key_base

## Configure your database

# TODO: Dry this up across cf/heroku

captures = if (System.get_env("DYNO")) do
  env_var_with_db_url = System.get_env("DATABASE_URL")

  # TODO: Instead hack it with a regex
  # NOTE! End-of line anchor instead of quote on heroku version
  db_creds_uri_parser_regex =
   ~r{postgres://(?<username>\S+?):(?<password>\S+?)@(?<host>\S+?):(?<port>\d+)/(?<database>\S+?)$}
  captures = db_creds_uri_parser_regex
    |> Regex.named_captures(env_var_with_db_url)
  captures
else
  # TODO: would like to parse JSON like this, but not sure how to pull in Poison module
  #       during Mix config phase, which is before any dependencies are loaded
  #db_creds_uri = env_var_with_db_url
  #  |> Poison.decode!
  #  |> Map.get("elephantsql")
  #  |> List.first
  #  |> Map.get("credentials")
  #  |> Map.get("uri")
  #  |> URI.parse
  #
  #[username, password] = String.split(db_creds_uri.userinfo, ":")
  #database = String.trim_leading(db_creds_uri.path, "/")
  #%{host: host, port: port} = db_creds_uri

  # TODO: Instead hack it with a regex
  db_creds_uri_parser_regex =
   ~r{postgres://(?<username>\S+?):(?<password>\S+?)@(?<host>\S+?):(?<port>\d+)/(?<database>\S+?)"}
  captures =
    db_creds_uri_parser_regex
    |> Regex.named_captures(System.get_env("VCAP_SERVICES"))
  captures
end

%{"username" => username, "password" => password, "host" => host, "port" => port, "database" => database} = captures


config :cf_phoenix, CfPhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: username,
  password: password,
  database: database,
  hostname: host,
  port: port,
  pool_size: 2
