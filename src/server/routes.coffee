logger = require './lib/logger'
Sync =  require 'sync'

module.exports = (app, passport) ->

  loadUser = (req, res, next) ->
    if 'user' of req
      req.user.info( -> )
      next()
    else
      req.user = id: '0'
      next()

  user = require './controllers/user'
  # user query handlers
  app.post '/api/user/session', passport.authenticate('local',
    failureFlash: 'Invalid email or password'
  ), user.login

  app.get '/api/user/logout', user.logout
  app.get '/api/user/me', loadUser, user.me
  app.post '/api/user/create', user.create

  app.all '*', loadUser

  # default and login page handlers
  home = require './controllers/home'
  app.get '/', home.index
  app.get '/search/*', home.index
  app.get '/searchtrail/*', home.index

  # search query handlers
  search = require './controllers/search'
  app.get '/api/search/:category/:searchCtxtId/:stageId/:query', search.get

  # search context query handlers
  searchContext = require './controllers/search-context'
  app.get '/api/searchctxt/new', searchContext.new
  app.get '/api/searchctxt/sync/:searchCtxtId/:stageId/:query', searchContext.sync
  app.get '/api/searchctxt/advance/:searchCtxtId/:query/:keywordIds', searchContext.advance
  app.get '/api/searchctxt/summary/:searchCtxtId/:stageId', searchContext.summary
  app.get '/api/searchctxt/add/ctxtkeyword/:searchCtxtId/:stageId/:keyword/:keyid', searchContext.addCtxtKeyword
  app.get '/api/searchctxt/suggest/ctxtkeywords/:query', searchContext.suggestCtxtKeywords
  app.get '/api/searchctxt/suggest/query/:query', searchContext.suggestQuery

  # search trail query handlers
  searchTrail = require './controllers/search-trail'
  app.get '/api/searchtrail/for/searchctxt/:searchCtxtId', searchTrail.forSearchContext
  app.get '/api/searchTrail/for/user/:userId', searchTrail.forUser
  app.get '/api/searchtrail/results/:category/:searchCtxtId/:stageId', searchTrail.results

  # discover query handlers
  discover = require './controllers/discover'
  app.get '/api/discover/get/keywords/:category/:itemId', discover.getKeywords

  item = require './controllers/item'
  app.get '/api/item/get/detail/:category/:id', item.getDetail
