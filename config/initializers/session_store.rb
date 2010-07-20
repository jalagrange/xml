# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_xml_session',
  :secret      => '822d77a3a21e65b4a7424123fb9927fcf3b6c296bb326676e9fb797e693d350fe50c2847ed019e2697d847917ec377cd613d1020ff06d5bbd5787aca99fbf4c9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
