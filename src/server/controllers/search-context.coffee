logger = require '../lib/logger'

SearchContext = require '../models/search-context'
searchContext = new SearchContext

exports.new = (req, res) ->
  searchContext.new(
    "0",
    (searchContextId, err) ->
      if (err)
        logger.log('error', err)
      else
        res.send(
          'searchContextId': searchContextId
          'stageId': '1'
          'query': ''
          'contextKeywords': []
        )
  )

exports.sync = (req, res) ->
  sCtxtId = req.params.searchCtxtId
  stageId = req.params.stageId
  query = req.params.query

  searchContext.sync(
    "0",
    sCtxtId,
    stageId,
    query,
    (sCtxt, err) ->
      if(err)
        logger.log('error', err)
      else res.send sCtxt
    )

exports.summary = (req, res) ->
  sCtxtId = req.params.searchCtxtId
  stageId = req.params.stageId

  searchContext.detail(
    "0",
    sCtxtId,
    stageId,
    (sCtxt, err) ->
      if(err)
        logger.log('error', err)
      else res.send sCtxt
  )

exports.addCtxtKeyword = (req, res) ->
  sCtxtId = req.params.searchCtxtId
  stageId = req.params.stageId
  keyword = req.params.keyid + ':' + req.params.keyword

  searchContext.addCtxtKeyword(
    "0",
    sCtxtId,
    stageId,
    keyword,
    (result, err) ->
      if(err)
        logger.log('error', err)
        res.send persisted: false
      else res.send persisted: true
  )

exports.suggestCtxtKeywords = (req, res) ->
  res.send([{
              name: 'Physics'
              keyid: '12334SD45'
            },
            {
              name: 'Theory'
              keyid: '3J45JJRJ'
            },
            {
              name: 'Relativity'
              keyid: '23JJK45'
            },
            {
              name: 'Two body problem'
              keyid: '3495345'
            },
            {
              name: 'General Theory of Relativity'
              keyid: '346657'
            },
            {
              name: 'Minkowski matrix'
              keyid: '345345'
            },
            {
              name: "Dark Matter"
              keyid: '34534234'
            },
            {
              name: "Cosmology"
              keyid: '123689'
            },
            {
              name: "Germany"
              keyid: '245876'
            },
            {
              name: "Scientist"
              keyid: '2348456'
            },
            {
              name: "Nobel Prize"
              keyid: '23468'
            }
    ])

exports.suggestQuery = (req, res) ->
  query = req.params.query
  query += "asdf"
  setTimeout((() ->
    res.send({
      suggestion:  query
    })
  ), 400)