define [
  'config'
  'controllers/base/controller'
  'models/search-context'
  'views/search-context-page-view'
], (config, Controller, SearchContext, SearchContextPageView) ->
  'use strict'

  class SearchContextController extends Controller
    initialize: ->
      @show()

    show: ->
      @url = config.api.versionRoot

      @model = new SearchContext
      @model.url = @url + "/searchctxt/init"

      @view = new SearchContextPageView {model: @model}
      @model.fetch()   
