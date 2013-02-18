define [
  'jquery'
  'views/base/page-view'
  'views/keyword/keywords-view'
  'text!views/templates/keyword/keyword-page.hbs'
], ($, PageView, KeywordsView, template) ->
  'use strict'

  class KeywordsPageView extends PageView
    template: template
    container: '#right-sidebar'

    initialize: -> 
      super

    renderSubviews: ->
      super
      @keywords_view = new KeywordsView
        collection: @collection
        container: @$('#keyword-result-container')
        itemView: @options.keywordItemView
        query: @options.query
      @keywords_view.render() 
      @$('#keyword-result-container > input').keyup(() =>
        keyword = @$('#keyword-result-container > input').val()
        @keywords_view.filter((item, index) =>
          if item.attributes.name  == keyword
            return true
          else
            return false
        (view, included) =>
          if not included
            view.$el.hide()
          else
            view.$el.show()
        )
      )
