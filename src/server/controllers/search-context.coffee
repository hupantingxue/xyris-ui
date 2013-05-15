exports.new = (req, res) ->
  res.send({
    newSearchContext:
      searchContextId: '1330990ASD89ASD' + Math.floor(Math.random() * 100 + 1)
      stageId: '1'
      query: ''
      contextKeywords: []
  })

exports.summary = (req, res) ->
  res.send({
    currentSearchContext:
      searchContextId: req.params.searchCtxtId
      stageId: req.params.stageId
      contextKeywords: [
        'Albert Einstein',
        'Theory of Relativity'
      ]
      category: 'web'
      query: 'Albert Einstein work on Theory of Relativity'
  })

exports.addCtxtKeyword = (req, res) ->
  res.send({
    persisted: true
  })

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