define [
  'handlebars'
  'views/base/view'
], (Handlebars, View) ->
  'use strict'

  # @deprecated
  #   will be either removed or its purpose will entirely change
  class PageView extends View
    renderedSubviews: no

    initialize: ->
      super
      @modelOrCollection = @model or @collection
      if @modelOrCollection
        rendered = no
        @listenTo @modelOrCollection, 'change', =>
          @render() unless rendered
          rendered = yes

    renderSubviews: ->
      return

    render: ->
      super
      unless @renderedSubviews
        @renderSubviews()
        @renderedSubviews = yes
