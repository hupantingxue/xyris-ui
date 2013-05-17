pool = require '../lib/redis-client'

class RedisModel
  client_pool: pool

  constructor: () ->

  execCmd: (cmd) ->
    @client_pool.acquire((err, client) =>
      if(err)
        throw new Error(err)
      else
        cmd(client, () =>
          @client_pool.release(client)
        )
    )

  cKey: (userId, searchContextId) ->
    userId + ':c:' + searchContextId

  stageKey: (userId, searchContextId, stageId) ->
    userId + ':s:' + searchContextId + ':' + stageId

module.exports = RedisModel