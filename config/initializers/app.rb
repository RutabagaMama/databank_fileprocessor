begin

  config_filename = File.join(Rails.root, 'config', 'app.yml')

  APP_CONFIG = YAML.load(ERB.new(File.read(config_filename)).result)

  Application.storage_manager = StorageManager.new
rescue Exception => ex
  Rails.logger.warn ex.message
  raise ex
end
