pool = require '../lib/redis-client'

class RedisModel
  client_pool: pool

  constructor: () ->
    console.log("sdf")

  execCmd: (cmd) ->
    @client_pool.acquire((err, client) =>
      if(err)
        throw new Error(err)
      else
        cmd(client, () =>
          @client_pool.release(client)
        )
    )

module.exports = RedisModel