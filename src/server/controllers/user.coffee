User = require '../models/user'
UserUtility = require '../models/user-utility'
userUtility = new UserUtility
logger = require '../lib/logger'

exports.me = (req, res) ->
  logger.log('info', req.user)
  if 'user' of req
    req.user.info () ->
      res.send(
        id: req.user.id
        email: req.user.email
        firstName: req.user.firstName
        lastName: req.user.lastName
      )
  else
    res.send(
      id: '0'
    )

exports.login = (req, res) ->
  res.send
    message: req.session.messages

exports.logout = (req, res) ->
  req.logout()
  res.send(message: 'done')

exports.create = (req, res) ->
  userUtility.create(req.query, (message, err) ->
    res.send message
  )
