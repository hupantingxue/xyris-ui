define [
  'config'
], (config) ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is match method of the Router
  (match) ->
    # match 'search/:cat/:searchContextId/:stageId/:query',
    #       'search-result#show',
    #       name: 'search_result'

    for searchOption in config.search.options
      match 'search/' + searchOption.urlKey + '/:searchContextId/:stageId/:query',
            searchOption.controller + '#show',
            name: searchOption.routeName,
            params: {
              cat: searchOption.category
              showDetail: false
            }

      match 'search/' + searchOption.urlKey + '/:searchContextId/:stageId/:query/detail/:id',
            searchOption.controller + '#show',
            name: searchOption.routeName,
            params: {
              cat: searchOption.category
              showDetail: true
            }
    match '', 'dummy#do_nothing', name: 'index'