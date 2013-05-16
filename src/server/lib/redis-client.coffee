generic_pool = require 'generic-pool'
redis = require 'redis'
config = require '../config'

pool = generic_pool.Pool(
  name: 'redis',
  create: (callback) ->
    client = redis.createClient(config.redis_port, config.redis_host)
    callback(null, client)
  destroy: (client) ->
    client.quit()
  max: 2
  min: 1
  idleTimeoutMillis: 300000
)

module.exports = pool