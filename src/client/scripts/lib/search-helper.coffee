define [
  'jquery'
  'config'
], ($, config) ->
  'use strict'

  routeNames = []
  for searchOption in config.search.options
    routeNames.push searchOption.routeName

  searchHelper =
    isValidRouteName: (routeName) ->
      console.log(routeName)
      if $.inArray(routeName, routeNames) != -1
        return true
      else
        return false

  return searchHelper
