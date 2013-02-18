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
    jquery: "vendor/jquery-1.8.3"
    underscore: "vendor/underscore-1.4.3"
    backbone: "vendor/backbone-0.9.9"
    handlebars: "vendor/handlebars-1.0.rc.1"
    text: "vendor/require-text-2.0.3"
    chaplin: "vendor/chaplin-0.6.0"
    jqueryui: "plugins/jquery-ui"
    orbit: "plugins/jquery.foundation.orbit"
    modernizr: "plugins/modernizr.foundation"

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
