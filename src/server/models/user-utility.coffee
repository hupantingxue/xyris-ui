RedisModel = require './model'
User = require './user'
uuid = require 'node-uuid'
bcrypt = require 'bcrypt'

module.exports =
class UserUtility extends RedisModel

  find: (options, result) ->
    if 'email' of options
      @execCmd (client, done) =>
        client.get(
          @userEmailKey(options.email),
          (err, res) ->
            done()
            if(err)
              result null, err
            else
              result new User(res), err
        )
    else if '_id' of options
      @execCmd (client, done) =>
        client.exists(
          @userIdKey(options._id),
          (err, res) ->
            done()
            if(err)
              result null, err
            else
              result new User(options._id), null
        )

  create: (options, result) ->
    @execCmd (client, done) =>
      client.exists(
        @userEmailKey(options.email),
        (err, res) =>
          if(err)
            done()
            result null, err
          else if res is 1
            done()
            result
              created: false
              message: 'Already an account with this email'
              null
          else
            client.incr(
              'maxuserid',
              (err, res) =>
                id = res
                salt = bcrypt.genSaltSync(10)
                password = bcrypt.hashSync(options.password, salt)
                multi = client.multi()
                multi.set(@userEmailKey(options.email), id)
                multi.hmset(@userIdKey(id),
                  'firstName',
                  options.firstName,
                  'lastName',
                  options.lastName,
                  'password',
                  password,
                  'email',
                  options.email
                )
                multi.exec (err, res) ->
                  if err
                    result null, err
                  else
                    result
                      created: true
                      null
            )
      )

  userEmailKey: (emailId) ->
    'user:e:' + emailId

  userIdKey: (id) ->
    'user:i:' + id