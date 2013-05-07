module.exports = (app) ->
  controllers = require './controllers/controllers'

  # Home page
  app.get '/v1/search/books', controllers.getBooks
  app.get '/v1/search/web', controllers.getWeb
  app.get '/', controllers.getHome
  app.get '/search/*', controllers.getHome
  app.get '/v1/get/keyword', controllers.getKeyword

  # Search SearchContext Related apis
  app.get '/v1/searchctxt/init', controllers.initSearchContext
  app.get '/v1/searchctxt/getinfo', controllers.getSearchContextInfo
  app.get '/v1/searchctxt/get/keyword', controllers.getKeyword
  app.get '/v1/searchctxt/addKeyword', controllers.addContextKeyword

  app.get '/v1/suggest/query/:query', controllers.getSuggestedQueries
  app.get '/v1/typeahead/suggest', controllers.getTypeaheadSuggestion

  app.get '/v1/getWebEntry', controllers.getWebEntry