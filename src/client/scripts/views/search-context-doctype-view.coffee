define [
  'views/base/view'
  'text!views/templates/search-context-doctype.hbs'
], (View, template) ->
  'use strict'

  class SearchContextDoctypeView extends View
    autoRender: yes
    template: template
    containerMethod: 'html'

    initialize: ->
      super

    attach: ->
      super
      @subscribeEvent 'searchctxt:queryEntered', (attributes) =>
        query = encodeURIComponent(attributes.query)
        @$('.web a').attr('href', '/search/web/' + @model.attributes.searchContextId + '/' + @model.attributes.stageId + '/' + query)
        @$('.news a').attr('href', '/search/news/' + @model.attributes.searchContextId + '/' + @model.attributes.stageId + '/' + query)
        @$('.books a').attr('href', '/search/books/' + @model.attributes.searchContextId + '/' + @model.attributes.stageId + '/' + query)
