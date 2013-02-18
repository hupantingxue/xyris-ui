define () ->

  config = {api: {}}

  production = no

  config.api.root = if production
    'http://localhost'
  else
    'http://localhost:8888'

  config.api.versionRoot = config.api.root + '/v1'
  return config
