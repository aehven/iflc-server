CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'                        # required
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     ENV['ACCESS_KEY_ID'],
    google_storage_secret_access_key: ENV['SECRET_ACCESS_KEY']
  }
  config.fog_directory = ""
end
