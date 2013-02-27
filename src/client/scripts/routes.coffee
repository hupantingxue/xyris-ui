define ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is match method of the Router
  (match) ->
    match 'search/books/:searchContextId/:stageId/:query', 'search-books#show', name: 'search_books'
    match 'search/books/:searchContextId/:stageId/:query/:filterKeyword', 'search-books#show', name: 'filter_books'

    match 'search/web/:searchContextId/:stageId/:query', 'search-web#show', name: 'search_web'
    match 'search/web/:searchContextId/:stageId/:query/:filterKeyword', 'search-web#show', name: 'filter_web'

    match 'search/news/:query', 'search-news#show', name: 'search_news'
    match '', 'publish-event#show_search', name: 'show_search'
