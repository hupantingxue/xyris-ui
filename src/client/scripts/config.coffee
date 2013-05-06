define () ->

  config =
    api: {}
    search: {}

  production = no

  config.api.root = if production
    'http://localhost'
  else
    'http://localhost:8888'

  config.api.versionRoot = config.api.root + '/v1'
  config.search.options = [
    {
      name: 'web'
      urlKey: 'web'
      category: 'web'
      controller: 'web-search'
      routeName: 'web_search'
    },
    {
      name: 'documents'
      urlKey: 'docs'
      category: 'docs'
      controller: 'docs-search'
      routeName: 'docs_search'
    },
    {
      name: 'research article'
      urlKey: 'rsrchart'
      category: 'rsrchart'
      controller: 'rsrchart-search'
      routeName: 'rsrchart_search'
    }
  ]
  return config
