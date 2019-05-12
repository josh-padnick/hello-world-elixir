# In this file, we load production configuration and
# secrets from environment variables. You can also
# hardcode secrets, although such is generally not
# recommended and you have to remember to add this
# file to your .gitignore.
use Mix.Config

# secret_key_base =
#   System.get_env("SECRET_KEY_BASE") ||
#     raise """
#     environment variable SECRET_KEY_BASE is missing.
#     You can generate one by calling: mix phx.gen.secret
#     """

# TODO: This is terrible practice for prod, as a starting poing I just want to run the app; I'll deal with secrets later
secret_key_base = "NGF9fpV+rLwZ+FDvyuS+fKJxk01ZV7KgkudFOGPvgiTdSkni14ugKcp+bClUKhFb"

config :hello, HelloWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base
