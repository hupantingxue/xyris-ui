define [
  'chaplin'
  'views/layout'
  'routes'
  'controllers/base-layout-controller'
  'controllers/search-context-controller'
], (Chaplin,
    Layout,
    routes,
    BaseLayoutController,
    SearchContextController) ->
  'use strict'

  class XyrisApplication extends Chaplin.Application
    title: 'Xyris'

    initialize: ->
      super

      # Initialize core components
      @initDispatcher controllerSuffix: '-controller'
      @initLayout()
      @initComposer()
      @initMediator()

      # Application-specific scaffold
      @initControllers()

      # Register all routes and start routing
      @initRouter routes
      # You might pass Router/History options as the second parameter.
      # Chaplin enables pushState per default and Backbone uses / as
      # the root per default. You might change that in the options
      # if necessary:
      # @initRouter routes, pushState: false, root: '/subdir/'
      #
      # Freeze the application instance to prevent further changes
      Object.freeze? this

    initComposer: (options ={}) ->
      @composer = new Chaplin.Composer options

    # Override standard layout initializer
    # ------------------------------------
    initLayout: ->
      # Use an application-specific Layout class. Currently this adds
      # no features to the standard Chaplin Layout, it’s an empty placeholder.
      @layout = new Layout {@title}

    # Instantiate common controllers
    # ------------------------------
    initControllers: ->
      # These controllers are active during the whole application runtime.
      # You don’t need to instantiate all controllers here, only special
      # controllers which do not to respond to routes. They may govern models
      # and views which are needed the whole time, for example header, footer
      # or navigation views.
      new BaseLayoutController
      new SearchContextController

    # Create additional mediator properties
    # -------------------------------------
    initMediator: ->
      # Create a user property
      Chaplin.mediator.user = null
      # Add additional application-specific properties and methods
      # Seal the mediator
      Chaplin.mediator.seal()

