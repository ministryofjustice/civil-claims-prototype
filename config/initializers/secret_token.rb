# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
CivilClaims::Application.config.secret_key_base = Rails.env.production? ? ENV['SESSION_SECRET_KEY'] : "2c86d2ccac8642b3b96a081a6be15729"
