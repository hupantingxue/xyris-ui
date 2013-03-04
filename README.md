Xyris UI
========

This is an initial version of a personal project, not open for open commit.
This repository will soon be private.

All tasks are tracked and assigned on Asana

Techs used
----------
### JavaScript
* JQuery
* jQuery UI
* Underscore (replace with lodash)
* Backbone.js
* Chaplin.js
* CoffeeScript
* require.js (add r.js)

### Templating
* Handlebar.js

### CSS
* Sass
* Foundation

### Build
* grunt
* bower

Authors
-------
Kumar Ishan - [@kumarishan](https://github.com/kumarishan)

Change Log
-----------
### 0.2.1
* migrated to chaplin 0.7.0
* added normalize.css
* migrated from sass to compass
* enabled compress in express to pass Google pagespeed
* added grunt-watch and grunt-open
* requirejs optimization using r.js - optimization using uglify2
* CoffeeScript linting enabled
Upcoming
as mentioned in previous changelog 0.2.0

### 0.2.0
Completely migrating to Grunt for build tool and bower for dependency management
Now code can be checked out and run directly given using grunt server and compiled
using grunt default
Grunt tasks active as of now includes
* coffeescript compilation
* sass and css compilation
* get dependency using bower
* bower require js hooks
* run express server

To do for subsequent releases (Apart from other milestones)
* proper grunt tasks to validate, compile, test, package, verify, install, deploy
* add vagrant + chef support

Carry forwarded todos from previous releases
* CSS refactoring to adopt mixed approach of OOCSS and SMACSS
* JS Structured coding
* Cross browser testing
* JS optimization using Closure compiler
* Lint everything
* Add phantomJS testing
* Fix transition from other page to search context page.
* Search context summary view -- a better approach

### 0.1.0
Basic functionality of the first page, better ui design
* The query textbox design changed
* Search option design changed
* Added more colors on the first page to attract attention and encourage actions
* Search context detection added
* Adopted better typography Lato and Source Sans Pro

To do for subsequent releases
* CSS refactoring to adopt mixed approach of OOCSS and SMACSS
* JS Structured coding
* Cross browser testing
* JS optimization using Closure compiler
* Lint everything
* Add phantomJS testing
* Fix transition from other page to search context page.
* Search context summary view -- a better approach
