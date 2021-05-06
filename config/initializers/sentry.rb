Sentry.init do |config|
  config.dsn = 'https://7c2251d6b0624de1b71be72492d3b69f@o563910.ingest.sentry.io/5704360'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.enabled_environments = %w[production]
end