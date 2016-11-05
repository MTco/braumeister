ENV['MEMCACHIER_SERVERS'] ||= ''

Braumeister::Application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.assets.compress = true
  config.assets.compile = false
  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_level = :warn

  config.cache_store = :dalli_store,
                       ENV['MEMCACHIER_SERVERS'].split(','),
                       {
                         username: ENV['MEMCACHIER_USERNAME'],
                         password: ENV['MEMCACHIER_PASSWORD']
                       }
end
