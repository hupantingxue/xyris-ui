RedisModel = require './model'
bcrypt = require 'bcrypt'
Sync = require 'sync'

module.exports =
class User extends RedisModel

  constructor: (id) ->
    @id = id

  info: (callback) ->
    if not @email
      @execCmd (client, done) =>
        client.hgetall(
          @userIdKey(@id),
          (err, res) =>
            done()
            if err
              throw new Error(err)
            else
              {@firstName, @lastName} = res
              {@email, @password} = res
            callback()
        )
    else
      callback

  authenticate: (password, result) ->
    Sync(() =>
      if !@password
        @info.sync(@)
      return bcrypt.compareSync(password, @password)
    ,(err, res) ->
      result(res)
    )

  userIdKey: (userId) ->
    'user:i:' + userId