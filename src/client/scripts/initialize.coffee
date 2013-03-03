###
Set the require.js configuration for your application
###

require.config(
  baseUrl: "/scripts/"
  paths:
    ###
    Javascript folders
    ###
    libs: "libs"
    plugins: "plugins"

    ###
    Libraries
    ###
    orbit: "vendor/jquery.foundation.orbit"
    chaplin: "vendor/chaplin-0.7.0"
    autosize: "vendor/jquery.autosize-1.15.2"

  shim:
    underscore:
      exports: "_"
    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"
    handlebars:
      exports: "Handlebars"
    jqueryui:
      deps: ["jquery"]
    orbit:
      deps: ["jquery"]
)

require ['jquery', 'xyris-application', 'jqueryui', 'orbit', 'modernizr'], ($, XyrisApplication) ->
  app = new XyrisApplication();
  app.initialize()
