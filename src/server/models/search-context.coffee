RedisModel = require './model'
uuid = require 'node-uuid'

class SearchContext extends RedisModel

  guestUserId: '0'
  expireTime:
    guestUser: '86400000' # 1 day

  contructor: () ->
    super

  new: (userId, result) ->
    searchContextId = uuid.v4()
    cKey = @cKey(userId, searchContextId)
    sKey = @stageKey(userId, searchContextId, '1')

    @execCmd (client, done) =>
      query = client.multi()
        .set(cKey, "1")
        .hset(sKey, "query", "")

      if(userId == @guestUserId)
        query.pexpire(cKey, @expireTime.guestUser)
        .pexpire(sKey, @expireTime.guestUser)

      query.exec (err, res) ->
        done()
        if(err)
          result(null, err)
        else
          result(searchContextId, null)

  sync: (userId, sCtxtId, stageId, query, result) ->
    @execCmd (client, done) =>
      client.hgetall(
        @stageKey(userId, sCtxtId, stageId),
        (err, res) =>
          if (err)
            done()
            result(null, err)
          else
            ret = () =>
              done()
              searchContext =
                'searchContextId': sCtxtId
                'stageId': stageId
                'query': query
                'contextKeywords':
                  @parseCtxtKeywords(res.contextKeywords) if 'contextKeywords' of res
              result(searchContext, null)

            if (/^\s*$/).test(res.query) && query isnt 'null'
              client.hset(
                @stageKey(userId, sCtxtId, stageId),
                "query",
                query,
                (err, res) =>
                  ret()
              )
            else
              query = res.query
              ret()
      )

  advance: (userId, sCtxtId, query, keywordIds, result) ->
    @execCmd (client, done) =>
      client.get(
        @cKey(userId, sCtxtId),
        (err, res) =>
          stageId = parseInt(res) + 1
          multi = client.multi()
          multi.incr @cKey(userId, sCtxtId)
          multi.hmset [
            @stageKey(userId, sCtxtId, stageId),
            'query',
            query,
            'contextKeywords',
            @makeCtxtKeywordStr(keywordIds)
          ]
          multi.exec (err, res) ->
            done()
            if (err)
              result(null, err)
            else result(stageId, null)
      )

  detail: (userId, sCtxtId, stageId, result) ->
    @execCmd (client, done) =>
      client.hgetall(
        @stageKey(userId, sCtxtId, stageId),
        (err, res) =>
          if (err)
            result(null, err)
          else
            searchContext =
              'searchContextId': sCtxtId
              'stageId': stageId
              'query': ''
              'contextKeywords': []
            searchContext.query = res.query
            searchContext.contextKeywords =
              @parseCtxtKeywords(res.contextKeywords) if 'contextKeywords' of res
            done()
            result(searchContext, null)
      )

  addCtxtKeyword: (userId, sCtxtId, stageId, keyword, result) ->
    sKey = @stageKey(userId, sCtxtId, stageId)

    @execCmd (client, done) =>
      query = client.hget(
        sKey,
        'contextKeywords',
        (err, res) ->
          if(err)
            result(null, err)
          else
            res = '' if !res?
            newKeywords = res + "," + keyword
            client.hset(
              sKey,
              'contextKeywords',
              newKeywords,
              (err, res) ->
                done()
                if(err)
                  result(null, err)
                else result(true, err)
            )
      )

  cKey: (userId, searchContextId) ->
    userId + ':c:' + searchContextId

  stageKey: (userId, searchContextId, stageId) ->
    userId + ':s:' + searchContextId + ':' + stageId

  parseCtxtKeywords: (keywords) ->
    ctxtKeywords = {}

    keywords.split(',').forEach (keyword, i) ->
      kv = keyword.split(':')
      ctxtKeywords[kv[0]] = kv[1]

    return ctxtKeywords

  makeCtxtKeywordStr: (keywords) ->
    strings = []
    for id, keyword of keywords
      strings.push(id + ':' + keyword)
    strings.join(',')

module.exports = SearchContext