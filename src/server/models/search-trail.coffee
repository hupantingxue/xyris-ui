RedisModel = require './model'
logger = require '../lib/logger'

class SearchTrail extends RedisModel
  constructor: () ->
    super

  get: (userId, sCtxtId, result) ->
    @execCmd (client, done) =>
      client.get(
        @cKey(userId, sCtxtId),
        (err, res) =>
          if(err)
            done()
            result(null, err)
          else
            maxStage = parseInt(res)
            multi = client.multi()
            stageId = 1
            while stageId <= maxStage
              multi.hgetall(
                @stageKey(userId, sCtxtId, stageId)
              )
              stageId = stageId + 1

            multi.exec (err, res) ->
              done()
              if(err)
                result(null, err)
              else
                trail = {}
                for id, det of res
                  keywords = []
                  if 'contextKeywords' of det
                    det.contextKeywords
                      .split(',')
                      .forEach (keyword) ->
                        keywords.push(keyword.split(':')[1])
                  trail[parseInt(id) + 1] =
                    'query': det.query
                    'keywords': keywords
                result(trail, null)
      )

module.exports = SearchTrail