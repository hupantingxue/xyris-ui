define () ->

  config =
    api: {}
    search: {}

  production = no

  config.api.root = if production
    ''
  else
    ''

  config.api.baseUrl = config.api.root + '/api'

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
